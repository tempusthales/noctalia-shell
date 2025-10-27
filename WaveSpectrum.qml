// WaveSpectrum.qml - Wave/line visualization
import QtQuick

Item {
  id: root

  // Public properties
  property var values: []
  property color fillColor: "#8bd5ff"

  // Canvas for rendering wave
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
      const stepX = W / (barCount - 1)

      ctx.strokeStyle = root.fillColor
      ctx.lineWidth = 2
      ctx.lineJoin = "round"

      ctx.beginPath()

      for (let i = 0; i < barCount; i++) {
        const normalizedValue = Math.max(0, Math.min(1, root.values[i]))
        const x = i * stepX
        const y = H - (normalizedValue * H)

        if (i === 0) {
          ctx.moveTo(x, y)
        } else {
          ctx.lineTo(x, y)
        }
      }

      ctx.stroke()

      // Optional: fill area under the wave
      ctx.lineTo(W, H)
      ctx.lineTo(0, H)
      ctx.closePath()
      ctx.fillStyle = root.fillColor
      ctx.globalAlpha = 0.3
      ctx.fill()
    }
  }

  // Trigger repaint when values change
  onValuesChanged: canvas.requestPaint()

  // Trigger repaint when dimensions change
  onWidthChanged: canvas.requestPaint()
  onHeightChanged: canvas.requestPaint()
}
