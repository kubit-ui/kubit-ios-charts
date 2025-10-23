import SwiftUI

struct KLineView: View {
    var xAxis: KAxis
    var yAxis: KAxis
    var line: KLine
    var scrollOffset: CGSize

    var body: some View {
        if case let .shadow(shadow) = self.line.style.decoration.type {
            lineView
                .shadow(color: shadow.color, radius: shadow.radius, x: shadow.offset.x, y: shadow.offset.y)
        } else if case let .background(background) = self.line.style.decoration.type {
            ZStack {
                areaView(background)
                lineView
            }
        } else if let zoomable = line.zoomable {
            ZStack {
                if zoomable.hasArea {
                    zoomableArea(zoomable.startHandle, zoomable.endHandle, zoomable.points)
                }
                zoomableLine(zoomable.startHandle, zoomable.endHandle, zoomable.points)
            }
        } else {
            lineView
        }
    }

    var lineView: some View {
        Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

            let path = Path.pathBuilder(
                points: sortedXPoints.map { $0.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size) },
                linePointAppearance: line.appearance,
                in: size)

            switch line.style.type {
            case .solid:
                context.stroke(path, with: .color(line.style.color), style: StrokeStyle(lineWidth: line.style.width))
            case let .dashed(pattern):
                context.stroke(
                    path,
                    with: .color(line.style.color),
                    style: StrokeStyle(lineWidth: line.style.width, dash: pattern))
            }
        }
    }

    @ViewBuilder
    func zoomableLine(_ startHandle: Double, _ endHandle: Double, _ points: [CGPoint]) -> some View {
        Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

            let zoomedPoints = mapperZoomedPoints(
                startHandle: startHandle,
                endHandle: endHandle,
                points: points,
                canvasSize: size)

            let path = Path.pathBuilder(
                points: zoomedPoints.mapped,
                linePointAppearance: line.appearance,
                in: size)

            context.stroke(path, with: .color(line.style.color), style: StrokeStyle(lineWidth: line.style.width))
        }
    }

    @ViewBuilder
    func zoomableArea(_ startHandle: Double, _ endHandle: Double, _ points: [CGPoint]) -> some View {
        Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

            let zoomedPoints = mapperZoomedPoints(
                startHandle: startHandle,
                endHandle: endHandle,
                points: points,
                canvasSize: size)

            var path = Path.pathBuilder(
                points: zoomedPoints.mapped,
                linePointAppearance: line.appearance,
                in: size)

            if let first = zoomedPoints.mapped.first, let last = zoomedPoints.mapped.last {
                path.addLine(to: CGPoint(x: last.x, y: size.height))
                path.addLine(to: CGPoint(x: first.x, y: size.height))
                path.closeSubpath()
            }

            context.fill(path, with: .color(Color(hex: "#CC3E42")!.opacity(0.25)), style: FillStyle())
        }
    }

    @ViewBuilder
    func areaView(_ background: KLine.Style.Background) -> some View {
        Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

            let mappedPoints = sortedXPoints.map { $0.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size) }
            var path = Path.pathBuilder(
                points: mappedPoints,
                linePointAppearance: line.appearance,
                in: size)
            let point1 = CGPoint(x: sortedXPoints.last?.x ?? .zero, y: background.yThreshold)
            let mappedPoint1 = point1.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size)
            let point2 = CGPoint(x: sortedXPoints.first?.x ?? .zero, y: background.yThreshold)
            let mappedPoint2 = point2.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size)
            path.addLine(to: mappedPoint1)
            path.addLine(to: mappedPoint2)
            path.closeSubpath()

            switch background.type {
            case let .plain(color):
                context.fill(path, with: .color(color), style: FillStyle())
            case let .linearGradient(gradient, startPoint, endPoint):
                context.fill(
                    path,
                    with: .linearGradient(
                        gradient,
                        startPoint: CGPoint(x: size.width * startPoint.x, y: startPoint.y * size.height),
                        endPoint: CGPoint(x: size.width * endPoint.x, y: endPoint.y * size.height)),
                    style: FillStyle())
            case let .radialGradient(gradient, center, startRadius, endRadius):
                context.fill(
                    path,
                    with: .radialGradient(
                        gradient,
                        center: CGPoint(x: center.x * size.width, y: center.y * size.height),
                        startRadius: startRadius,
                        endRadius: endRadius),
                    style: FillStyle())
            }
        }
    }
}

// MARK: - Private
private extension KLineView {
    var sortedXPoints: [CGPoint] {
        line.points.sorted { $0.x < $1.x }
    }
}
