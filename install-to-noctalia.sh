#!/bin/bash
# Script to copy widget files to noctalia-shell installation

# Set this to your noctalia-shell installation path
NOCTALIA_PATH="${1:-/etc/xdg/quickshell/noctalia-shell}"

if [ ! -d "$NOCTALIA_PATH" ]; then
  echo "Error: Noctalia path not found: $NOCTALIA_PATH"
  echo "Usage: $0 /etc/xdg/quickshell/noctalia-shell"
  exit 1
fi

echo "Installing CAVA Visualizer to: $NOCTALIA_PATH"

# Create directories if they don't exist
mkdir -p "$NOCTALIA_PATH/Modules/Bar/Widgets"
mkdir -p "$NOCTALIA_PATH/Modules/Settings/Bar/WidgetSettings"
mkdir -p "$NOCTALIA_PATH/Widgets"

# Copy main widget
echo "Copying CavaVisualizer.qml..."
cp CavaVisualizer.qml "$NOCTALIA_PATH/Modules/Bar/Widgets/"

# Copy settings UI
echo "Copying CavaVisualizerSettings.qml..."
cp CavaVisualizerSettings.qml "$NOCTALIA_PATH/Modules/Settings/Bar/WidgetSettings/"

# Copy spectrum components
echo "Copying spectrum visualizers..."
cp LinearSpectrum.qml "$NOCTALIA_PATH/Widgets/"
cp MirroredSpectrum.qml "$NOCTALIA_PATH/Widgets/"
cp WaveSpectrum.qml "$NOCTALIA_PATH/Widgets/"

# Copy documentation
echo "Copying CLAUDE.md..."
cp CLAUDE.md "$NOCTALIA_PATH/"

echo ""
echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Configure Settings.data.audio.visualizerType to 'linear', 'mirrored', or 'wave'"
echo "2. Add CavaVisualizer widget to your bar via the widget picker"
echo "3. Restart Noctalia: systemctl --user restart noctalia-shell.service"
echo "4. Check logs: journalctl --user -u noctalia-shell.service -f"
