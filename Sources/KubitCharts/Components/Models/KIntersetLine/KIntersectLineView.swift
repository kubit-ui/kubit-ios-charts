import SwiftUI

struct KIntersectLineView: View {
    var xAxis: KAxis
    var yAxis: KAxis
    var selectedNode: KNode
    var intersectLine: KIntersectLine
    var scrollOffset: CGSize

    var body: some View {
        lineView
    }

    var center: CGPoint {
        selectedNode.shape.unmappedCenter
    }
    var radius: CGFloat {
        selectedNode.shape.unmappedXRadius
    }
    var haloWidth: CGFloat {
        selectedNode.shape.unmappedHaloWidth
    }

    var lineView: some View {
        Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)
            if intersectLine.orientation == .horizontal, canDrawHorizontalIntersectLine {
                let lineOrigin = CGPoint(x: .zero, y: center.y).mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size)
                let finalX = if center.x < .zero {
                    center.x + radius + haloWidth
                } else {
                    center.x - radius - haloWidth
                }
                let lineEnd = CGPoint(x: finalX, y: center.y).mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size)
                var path = Path()
                path.move(to: lineOrigin)
                path.addLine(to: CGPoint(x: lineEnd.x + (center.x < 0 ? 8 : -8), y: lineEnd.y))
                context.stroke(
                    path,
                    with: .color(intersectLine.color),
                    style: StrokeStyle(lineWidth: intersectLine.width, dash: intersectLine.dashPattern))
            } else if intersectLine.orientation == .vertical, canDrawVerticalIntersectLine {
                let lineOrigin = CGPoint(x: center.x, y: .zero).mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size)
                let finalY = if center.y < .zero {
                    center.y + radius + haloWidth
                } else {
                    center.y - radius - haloWidth
                }
                let lineEnd = CGPoint(x: center.x, y: finalY).mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size)
                var path = Path()
                path.move(to: lineOrigin)
                path.addLine(to: CGPoint(x: lineEnd.x, y: lineEnd.y + (center.y < 0 ? -8 : 8)))
                context.stroke(
                    path,
                    with: .color(intersectLine.color),
                    style: StrokeStyle(lineWidth: intersectLine.width, dash: intersectLine.dashPattern))
            }
        }
    }

    var canDrawHorizontalIntersectLine: Bool {
        if center.x < .zero, center.x + radius + haloWidth < .zero {
            return true
        } else if center.x > .zero, center.x - radius - haloWidth > .zero {
            return true
        }
        return false
    }

    var canDrawVerticalIntersectLine: Bool {
        if center.y < .zero, center.y + radius + haloWidth < .zero {
            return true
        } else if center.y > .zero, center.y - radius - haloWidth > .zero {
            return true
        }
        return false
    }
}
