import SwiftUI
/// #  KLineView
///
/// [Figma design]
/// (https://www.figma.com/design/XJnmdNlhMwmyx4QpGGpIN3/-R.8--Kubit-Global-Documentation?node-id=58437-8709&t=gAeJoHOWllHv94Xr-1)
///
/// ## How to use it:
/// ```
/// let lines: [KLine] = KLine(
///     points: CGPoint(x: 1, y: 2),
///     appearance: .square,
///     style: .solid(
///         width: 2.0,
///         color: .red,
///         decoration: .background(.red),
///         accessibility: KLine.Accessibility(identifier: "KLineViewIdentifier"))
/// KAxisChart()
///     .addLines(lines)
/// ```
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

#if DEBUG
private struct KLineBarPreview: View {
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
    KLineBarPreview()
}
#endif
