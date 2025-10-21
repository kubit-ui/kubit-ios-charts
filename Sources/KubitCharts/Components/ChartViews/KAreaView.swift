import SwiftUI

struct KAreaView: View {
    var xAxis: KAxis
    var yAxis: KAxis
    var area: KArea
    var scrollOffset: CGSize

    var body: some View {
        ZStack {
            if case let .background(background) = self.area.decoration.type {
                areaView(background)
            }

            lineView(area.mainLine)
            if let aboveLine = area.aboveLine {
                lineView(aboveLine)
            }
            if let belowLine = area.belowLine {
                lineView(belowLine)
            }
        }
    }

    func lineView(_ line: KArea.Line) -> some View {
        Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

            let path = Path.pathBuilder(
                points: line.sortedXPoints.map { $0.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size) },
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
    func areaView(_ background: KArea.Decoration.Background) -> some View {
        Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

            let path = area.fullPath(xAxis: xAxis, yAxis: yAxis, canvasSize: size)

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

#if DEBUG
private struct KAreaPreview: View {
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

    func exponentialPoints(_ initialY: CGFloat = 3, factor: CGFloat = 10.0) -> [CGPoint] {
        var points = [CGPoint]()

        let numberOfPoints = 10
        for index in 0...numberOfPoints {
            let xPosition = CGFloat(index)
            let yPosition = initialY + 0.8 * exp(xPosition / factor)
            points.append(CGPoint(x: xPosition, y: yPosition))
        }
        return points
    }

    var area: KArea {
        KArea(
            mainLine: KArea.Line(
                points: exponentialPoints(factor: 4),
                appearance: .square,
                style: .solid(width: 3.0, color: .black)),
            aboveLine: KArea.Line(
                points: exponentialPoints(factor: 5),
                appearance: .square,
                style: .solid(width: 1.0, color: .black)),
            belowLine: KArea.Line(
                points: exponentialPoints(factor: 3),
                appearance: .square,
                style: .solid(width: 1.0, color: .black)),
            decoration: .background(.linearGradient(
                Gradient(colors: [Color.yellow, .brown, .orange]),
                startPoint: UnitPoint(x: 0.4, y: 0.7),
                endPoint: UnitPoint(x: 1.0, y: 0.1))),
            accessibilityIdentifier: "IdArea1")!
    }

    var body: some View {
        KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
            .addArea(area)
            .frame(maxWidth: .infinity)
            .padding()
    }
}

#Preview {
    KAreaPreview()
}
#endif

