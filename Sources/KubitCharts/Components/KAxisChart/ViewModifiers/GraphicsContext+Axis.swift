import SwiftUI

extension GraphicsContext {
    func drawAxis(axis: KAxis, size: CGSize, lines: [KAxis.LineData]) {
        for (index, line) in lines.enumerated() {
            let lineStyle = axis.points[index].lineStyle
            guard lineStyle.visible else {
                continue
            }

            var path = Path()
            path.move(to: line.origin)
            path.addLine(to: line.end)
            stroke(
                path,
                with: .color(lineStyle.color ?? axis.linesStyle.defaultColor),
                style: StrokeStyle(lineWidth: lineStyle.width ?? axis.linesStyle.defaultWidth, dash: lineStyle.dashPattern))
        }
    }

    func drawLabels(axis: KAxis, size: CGSize, labelPoints: [CGPoint], anchor: UnitPoint) {
        for (index, point) in labelPoints.enumerated() {
            let labelStyle = axis.points[index].labelStyle
            if let label = labelStyle.value {
                let text = Text(label)
                    .font(labelStyle.font ?? axis.labelsStyle.defaultFont)
                    .foregroundColor(labelStyle.color ?? axis.labelsStyle.defaultColor)

                if let rotation = labelStyle.rotation, rotation != .zero {
                    drawLayer { context in
                        context.translateBy(x: point.x, y: point.y)
                        context.rotate(by: rotation)
                        context.draw(text, at: .zero, anchor: anchor)
                    }
                } else {
                    draw(text, at: point, anchor: anchor)
                }
            }
        }
    }
}
