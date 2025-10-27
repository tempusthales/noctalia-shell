// LinearSpectrum.qml - Simple linear bar visualization
import QtQuick

Item {
  id: root

  // Public properties
  property var values: []
  property color fillColor: "#8bd5ff"

  // Canvas for rendering bars
  Canvas {
    id: canvas
    anchors.fill: parent
    renderTarget: Canvas.FramebufferObject

    onPaint: {
      const ctx = getContext("2d")
      const W = width
      const H = height

      ctx.clearRect(0, 0, W, H)

      if (!root.values || root.values.length === 0) return

      const barCount = root.values.length
      const spacing = 1  // Spacing between bars
      const barWidth = Math.max(2, (W / barCount) - spacing)  // Dynamic bar width
      const barSpacing = barWidth + spacing

      ctx.fillStyle = root.fillColor

      for (let i = 0; i < barCount; i++) {
        const normalizedValue = Math.max(0, Math.min(1, root.values[i]))
        const barHeight = normalizedValue * H
        const x = i * barSpacing
        const y = H - barHeight

        ctx.fillRect(x, y, barWidth, barHeight)
      }
    }
  }

  // Trigger repaint when values change
  onValuesChanged: canvas.requestPaint()

  // Trigger repaint when dimensions change
  onWidthChanged: canvas.requestPaint()
  onHeightChanged: canvas.requestPaint()
}
