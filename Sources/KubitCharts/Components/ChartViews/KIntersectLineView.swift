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

#if DEBUG
private struct KIntersectLinePreview: View {
    let xAxis = KAxisBuilder()
        .addPointWithDefaultSolidLine(0.0, labelStyle: .labeled("0"))
        .addPointWithDefaultSolidLine(10.0, labelStyle: .labeled("10"))
        .setLabelsViewPosition(.end)
        .build()
    let yAxis = KAxisBuilder()
        .addPointWithDefaultSolidLine(0.0, labelStyle: .labeled("0"))
        .addPointWithDefaultSolidLine(10.0, labelStyle: .labeled("10"))
        .setLabelsViewPosition(.start)
        .build()
    let line = KLine(
        points: [
            CGPoint(x: 0.0, y: 1.0),
            CGPoint(x: 1.0, y: 1.2),
            CGPoint(x: 2.0, y: 3.0),
            CGPoint(x: 3.0, y: 1.0),
            CGPoint(x: 4.0, y: 2.0),
            CGPoint(x: 5.0, y: 5.0),
            CGPoint(x: 6.0, y: 6.0),
            CGPoint(x: 7.0, y: 8.0),
            CGPoint(x: 8.0, y: 3.0),
            CGPoint(x: 8.0, y: 1.0),
            CGPoint(x: 10.0, y: 0.0)],
        appearance: .rounded,
        style: .solid(width: 2.0, color: .blue, decoration: .background(.linearGradient(Gradient(colors: [.kubit, .clear])))),
        accessibilityIdentifier: "Identifier")

    let line2 = KLine(
        points: [
            CGPoint.zero,
            CGPoint(x: 1.0, y: 0.2),
            CGPoint(x: 2.0, y: 2.0),
            CGPoint(x: 3.0, y: 2.0),
            CGPoint(x: 4.0, y: 6.0),
            CGPoint(x: 5.0, y: 3.0),
            CGPoint(x: 6.0, y: 1.0),
            CGPoint(x: 7.0, y: 7.0),
            CGPoint(x: 8.0, y: 2.0),
            CGPoint(x: 8.0, y: 4.0),
            CGPoint(x: 10.0, y: 1.0)],
        appearance: .rounded,
        style: .solid(
            width: 2.0,
            color: .blue,
            decoration: .background(.radialGradient(
                Gradient(colors: [.blue, .yellow, .green]),
                center: UnitPoint(x: 0.5, y: 0.75),
                startRadius: 30.0,
                endRadius: 500.0))),
        accessibilityIdentifier: "Identifier2")

    func exponentialPoints(_ initialY: CGFloat = 3) -> [CGPoint] {
        var points = [CGPoint]()

        let numberOfPoints = 10
        for index in 0...numberOfPoints {
            let xPosition = CGFloat(index)
            let yPosition = initialY + 0.8 * exp(xPosition / 10)
            points.append(CGPoint(x: xPosition, y: yPosition))
        }
        return points
    }

    var line3: KLine {
        KLine(
            points: exponentialPoints(5),
            appearance: .square,
            style: .solid(width: 2.0, color: .black),
            accessibilityIdentifier: "Id3")
    }

    var body: some View {
        KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
            .addLines([line, line2, line3])
            .frame(maxWidth: .infinity)
            .padding()
    }
}

#Preview {
    KIntersectLinePreview()
}
#endif
