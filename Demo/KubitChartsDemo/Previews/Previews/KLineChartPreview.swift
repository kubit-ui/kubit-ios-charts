import KubitCharts
import SwiftUI

struct KLineChartPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                variants
                appearance
                lineAppearance
                areaAppearance
                value
                layout
            }
        }
        .background(Color(hex: "#F0F0F0") ?? .white)
    }
}

// MARK: - Variants
private extension KLineChartPreview {
    var variants: some View {
        VStack {
            Text("Variants")
                .font(.largeTitle)
            lineChart
            areaChart
        }
    }

    var lineChart: some View {
        KLineChartSection(
            title: "Line Chart",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [line(style: .solid(width: 2.0, color: Color(hex: "#CC3E42")!, decoration: plainBackgroundDecoration))])
    }

    var areaChart: some View {
        let lines = areaLines(appearance: .rounded)
        return KLineChartSection(
            title: "Area Chart",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            areas: [area(mainLine: lines.main, aboveLine: lines.above, belowLine: lines.below, decoration: plainAreaDecoration)])
    }
}

// MARK: - Appearance
private extension KLineChartPreview {
    var appearance: some View {
        VStack {
            Text("Appearance")
                .font(.largeTitle)
            lineRounded
            lineRoundedWithBg
            areaRounded
            lineSquare
            lineSquareWithBg
            areaSquare
        }
    }

    var lineRounded: some View {
        KLineChartSection(
            title: "Line Rounded",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [line(style: .solid(width: 2.0, color: Color(hex: "#CC3E42")!, decoration: .none))])
    }

    var lineRoundedWithBg: some View {
        KLineChartSection(
            title: "Line Rounded With Background",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [line(style: .solid(width: 2.0, color: Color(hex: "#CC3E42")!, decoration: plainBackgroundDecoration))])
    }

    var areaRounded: some View {
        let lines = areaLines(appearance: .rounded)
        return KLineChartSection(
            title: "Area Rounded",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            areas: [area(mainLine: lines.main, aboveLine: lines.above, belowLine: lines.below, decoration: plainAreaDecoration)])
    }

    var lineSquare: some View {
        KLineChartSection(
            title: "Line Square",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [line(appearance: .square, style: .solid(width: 2.0, color: Color(hex: "#CC3E42")!, decoration: .none))])
    }

    var lineSquareWithBg: some View {
        KLineChartSection(
            title: "Line Square With Background",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [
                line(
                    appearance: .square,
                    style: .solid(width: 2.0, color: Color(hex: "#CC3E42")!, decoration: plainBackgroundDecoration))
            ])
    }

    var areaSquare: some View {
        let lines = areaLines(appearance: .square)
        return KLineChartSection(
            title: "Area Square",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            areas: [area(mainLine: lines.main, aboveLine: lines.above, belowLine: lines.below, decoration: plainAreaDecoration)])
    }
}

// MARK: - Line appearance
private extension KLineChartPreview {
    var lineAppearance: some View {
        VStack {
            Text("Line appearance")
                .font(.largeTitle)
            solid
            dashed
            shadow
            custom
        }
    }

    var solid: some View {
        KLineChartSection(
            title: "Solid line",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [line(style: .solid(width: 2.0, color: Color(hex: "#CC3E42")!, decoration: .none))])
    }

    var dashed: some View {
        KLineChartSection(
            title: "Dashed line",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [line(style: .dashed(width: 2.0, color: Color(hex: "#CC3E42")!, decoration: .none))])
    }

    var shadow: some View {
        KLineChartSection(
            title: "Line with shadow",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [line(style: .solid(width: 2.0, color: Color(hex: "#CC3E42")!, decoration: .shadow(KLine.Style.Shadow())))])
    }

    var custom: some View {
        KLineChartSection(
            title: "Custom line",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [line(style: .dashed(width: 2.0, color: Color(hex: "#CC3E42")!, pattern: [6, 1, 3], decoration: .none))])
    }
}

// MARK: - Area appearance
private extension KLineChartPreview {
    var areaAppearance: some View {
        VStack {
            Text("Area appearance")
                .font(.largeTitle)
            below
            above
            aboveAndBelow
            multiple
        }
    }

    var below: some View {
        let lines = areaLines(appearance: .rounded)
        return KLineChartSection(
            title: "Below",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            areas: [area(mainLine: lines.main, aboveLine: nil, belowLine: lines.below, decoration: plainAreaDecoration)])
    }

    var above: some View {
        let lines = areaLines(appearance: .rounded)
        return KLineChartSection(
            title: "Above",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            areas: [area(mainLine: lines.main, aboveLine: lines.above, belowLine: nil, decoration: plainAreaDecoration)])
    }

    var aboveAndBelow: some View {
        let lines = areaLines(appearance: .rounded)
        return KLineChartSection(
            title: "Above and below",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            areas: [area(mainLine: lines.main, aboveLine: lines.above, belowLine: lines.below, decoration: plainAreaDecoration)])
    }

    var multiple: some View {
        let mainLine = KLine(
            points: SBAxisHelper.exponentialPoints(0, factor: 4.0),
            appearance: .square,
            style: .solid(
                width: 2.0,
                color: Color(hex: "#FF5F0F")!,
                decoration: .background(.plain(color: Color(hex: "#FF5F0F")!.opacity(0.25), yThreshold: 0))),
            accessibilityIdentifier: "Id.1")
        let belowLine = KLine(
            points: SBAxisHelper.exponentialPoints(0, factor: 3.0),
            appearance: .square,
            style: .solid(
                width: 2.0,
                color: Color(hex: "#CC3E42")!,
                decoration: .background(.plain(color: Color(hex: "#CC3E42")!.opacity(0.25), yThreshold: 0))),
            accessibilityIdentifier: "Id.2")
        let aboveLine = KLine(
            points: SBAxisHelper.exponentialPoints(0, factor: 5.0),
            appearance: .square,
            style: .solid(
                width: 2.0,
                color: Color(hex: "#B11F5D")!,
                decoration: .background(.plain(color: Color(hex: "#B11F5D")!.opacity(0.25), yThreshold: 0))),
            accessibilityIdentifier: "Id.3")
        return KLineChartSection(
            title: "Multiple",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [mainLine, belowLine, aboveLine])
    }
}

// MARK: - Value
private extension KLineChartPreview {
    var value: some View {
        VStack {
            Text("Value")
                .font(.largeTitle)
            positive
            negative
            positiveAndNegative
            positiveLine
            negativeLine
            neutral
        }
    }

    var positive: some View {
        let mainLine = KArea.Line(
            points: SBAxisHelper.exponentialPoints(0, factor: 5.0),
            appearance: .square,
            style: .solid(width: 2.0, color: Color(hex: "#FF5F0F")!))
        let aboveLine = KArea.Line(
            points: SBAxisHelper.exponentialPoints(0, factor: 4.0),
            appearance: .square,
            style: .solid(width: 1.0, color: Color(hex: "#0000FF")!))
        return KLineChartSection(
            title: "Positive",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            areas: [area(mainLine: mainLine, aboveLine: aboveLine, belowLine: nil, decoration: plainAreaDecoration)])
    }

    var negative: some View {
        let mainLine = KArea.Line(
            points: SBAxisHelper.exponentialPoints(0, factor: 5.0),
            appearance: .square,
            style: .solid(width: 2.0, color: Color(hex: "#FF5F0F")!))
        let belowLine = KArea.Line(
            points: SBAxisHelper.exponentialPoints(0, factor: 6.0),
            appearance: .square,
            style: .solid(width: 1.0, color: Color(hex: "#FF0000")!))
        return KLineChartSection(
            title: "Negative",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            areas: [area(mainLine: mainLine, aboveLine: nil, belowLine: belowLine, decoration: plainAreaDecoration)])
    }

    var positiveAndNegative: some View {
        let mainLine = KArea.Line(
            points: SBAxisHelper.exponentialPoints(0, factor: 5.0),
            appearance: .square,
            style: .solid(width: 2.0, color: Color(hex: "#FF5F0F")!))
        let aboveLine = KArea.Line(
            points: SBAxisHelper.exponentialPoints(0, factor: 4.0),
            appearance: .square,
            style: .solid(width: 1.0, color: Color(hex: "#0000FF")!))
        let belowLine = KArea.Line(
            points: SBAxisHelper.exponentialPoints(0, factor: 6.0),
            appearance: .square,
            style: .solid(width: 1.0, color: Color(hex: "#FF0000")!))
        return KLineChartSection(
            title: "Positive and Negative",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            areas: [area(mainLine: mainLine, aboveLine: aboveLine, belowLine: belowLine, decoration: plainAreaDecoration)])
    }

    var positiveLine: some View {
        let positiveLine = KLine(
            points: SBAxisHelper.exponentialPoints(0, factor: 5.0),
            appearance: .square,
            style: .solid(
                width: 2.0,
                color: Color(hex: "#FF5F0F")!,
                decoration: .background(.plain(color: Color(hex: "#FF5F0F")!.opacity(0.25)))),
            accessibilityIdentifier: "Ident.1")
        return KLineChartSection(
            title: "Positive line",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [positiveLine])
    }

    var negativeLine: some View {
        let negativeLine = KLine(
            points: SBAxisHelper.exponentialPoints(6, factor: -3.0),
            appearance: .square,
            style: .solid(
                width: 2.0,
                color: Color(hex: "#FF5F0F")!,
                decoration: .background(.plain(color: Color(hex: "#FF5F0F")!.opacity(0.25)))),
            accessibilityIdentifier: "Ident.1")
        return KLineChartSection(
            title: "Negative line",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [negativeLine])
    }

    var neutral: some View {
        let neutralLine = KLine(
            points: [CGPoint(x: 0.0, y: 5.0), CGPoint(x: 10.0, y: 5.0)],
            appearance: .square,
            style: .solid(
                width: 2.0,
                color: Color(hex: "#FF5F0F")!,
                decoration: .background(.plain(color: Color(hex: "#FF5F0F")!.opacity(0.25)))),
            accessibilityIdentifier: "Ident.1")
        return KLineChartSection(
            title: "Neutral line",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [neutralLine])
    }
}

// MARK: - Layout
private extension KLineChartPreview {
    var layout: some View {
        VStack {
            Text("Layout")
                .font(.largeTitle)
            oneLine
            severalLines
            oneArea
            severalAreas
        }
    }

    var oneLine: some View {
        KLineChartSection(
            title: "One line",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [line(style: .solid(width: 2.0, color: Color(hex: "#CC3E42")!, decoration: .none))])
    }

    var severalLines: some View {
        KLineChartSection(
            title: "Several line",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [
                line(style: .solid(width: 2.0, color: Color(hex: "#CC3E42")!, decoration: .none)),
                line(style: .solid(width: 2.0, color: Color(hex: "#D81DC5")!, decoration: .none)),
                line(style: .solid(width: 2.0, color: Color(hex: "#09A182")!, decoration: .none)),
                line(style: .solid(width: 2.0, color: Color(hex: "#673AB7")!, decoration: .none)),
                line(style: .solid(width: 2.0, color: Color(hex: "#CC6F3F")!, decoration: .none)),
                line(style: .solid(width: 2.0, color: Color(hex: "#3F51B5")!, decoration: .none))
            ])
    }

    var oneArea: some View {
        let mainLine = KArea.Line(
            points: SBAxisHelper.exponentialPoints(0, factor: 5.0),
            appearance: .square,
            style: .solid(width: 2.0, color: Color(hex: "#FF5F0F")!))
        let aboveLine = KArea.Line(
            points: SBAxisHelper.exponentialPoints(0, factor: 4.0),
            appearance: .square,
            style: .solid(width: 1.0, color: Color(hex: "#0000FF")!))
        return KLineChartSection(
            title: "Positive",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            areas: [area(mainLine: mainLine, aboveLine: aboveLine, belowLine: nil, decoration: plainAreaDecoration)])
    }

    var severalAreas: some View {
        let mainLine = KLine(
            points: SBAxisHelper.exponentialPoints(0, factor: 4.0),
            appearance: .square,
            style: .solid(
                width: 2.0,
                color: Color(hex: "#FF5F0F")!,
                decoration: .background(.plain(color: Color(hex: "#FF5F0F")!.opacity(0.25), yThreshold: 0))),
            accessibilityIdentifier: "Id.1")
        let belowLine = KLine(
            points: SBAxisHelper.exponentialPoints(0, factor: 3.0),
            appearance: .square,
            style: .solid(
                width: 2.0,
                color: Color(hex: "#CC3E42")!,
                decoration: .background(.plain(color: Color(hex: "#CC3E42")!.opacity(0.25), yThreshold: 0))),
            accessibilityIdentifier: "Id.2")
        let aboveLine = KLine(
            points: SBAxisHelper.exponentialPoints(0, factor: 5.0),
            appearance: .square,
            style: .solid(
                width: 2.0,
                color: Color(hex: "#B11F5D")!,
                decoration: .background(.plain(color: Color(hex: "#B11F5D")!.opacity(0.25), yThreshold: 0))),
            accessibilityIdentifier: "Id.3")
        return KLineChartSection(
            title: "Multiple",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(),
            lines: [mainLine, belowLine, aboveLine])
    }
}

// MARK: - Line Chart Section
private struct KLineChartSection: View {
    var title: String
    var xAxis: KAxis
    var yAxis: KAxis
    var lines = [KLine]()
    var areas = [KArea]()

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)

            lineChart
                .background(Color.white)
                .kRadius(12.0)
                .padding(.horizontal, 12.0)
        }
    }

    var lineChart: some View {
        KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
            .addLines(lines)
            .addAreas(areas)
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .padding(.leading, xAxis.startPadding)
            .padding(.top, yAxis.startPadding)
            .padding(.trailing, xAxis.endPadding)
            .padding(.bottom, yAxis.endPadding)
    }
}

// MARK: - Lines
private extension KLineChartPreview {
    func line(appearance: KLine.Appearance = .rounded, style: KLine.Style) -> KLine {
        let points: [CGPoint] = [
            CGPoint(x: 0.0, y: CGFloat.random(in: 0...10)),
            CGPoint(x: 1.0, y: CGFloat.random(in: 0...10)),
            CGPoint(x: 2.0, y: CGFloat.random(in: 0...10)),
            CGPoint(x: 3.0, y: CGFloat.random(in: 0...10)),
            CGPoint(x: 4.0, y: CGFloat.random(in: 0...10)),
            CGPoint(x: 5.0, y: CGFloat.random(in: 0...10)),
            CGPoint(x: 6.0, y: CGFloat.random(in: 0...10)),
            CGPoint(x: 7.0, y: CGFloat.random(in: 0...10)),
            CGPoint(x: 8.0, y: CGFloat.random(in: 0...10)),
            CGPoint(x: 9.0, y: CGFloat.random(in: 0...10)),
            CGPoint(x: 10.0, y: CGFloat.random(in: 0...10))]
        return KLine(
            points: points,
            appearance: appearance,
            style: style,
            accessibilityIdentifier: "lineWithBackground")
    }
}

// MARK: - Decorations
private extension KLineChartPreview {
    var plainBackgroundDecoration: KLine.Style.Decoration {
        .background(.plain(color: Color(hex: "#CC3E42")!.opacity(0.25)))
    }

    var plainAreaDecoration: KArea.Decoration {
        .background(.plain(color: Color(hex: "#CC3E42")!.opacity(0.25)))
    }
}

// MARK: - Areas
private extension KLineChartPreview {
    func area(mainLine: KArea.Line,
              aboveLine: KArea.Line?,
              belowLine: KArea.Line?,
              decoration: KArea.Decoration) -> KArea {
        KArea(
            mainLine: mainLine,
            aboveLine: aboveLine,
            belowLine: belowLine,
            decoration: decoration,
            accessibilityIdentifier: "Area.Identifier")!
    }

    // swiftlint:disable:next large_tuple
    func areaLines(appearance: KLine.Appearance) -> (main: KArea.Line, below: KArea.Line, above: KArea.Line) {
        let points: [CGPoint] = [
            CGPoint(x: 0.0, y: CGFloat.random(in: 1...9)),
            CGPoint(x: 1.0, y: CGFloat.random(in: 1...9)),
            CGPoint(x: 2.0, y: CGFloat.random(in: 1...9)),
            CGPoint(x: 3.0, y: CGFloat.random(in: 1...9)),
            CGPoint(x: 4.0, y: CGFloat.random(in: 1...9)),
            CGPoint(x: 5.0, y: CGFloat.random(in: 1...9)),
            CGPoint(x: 6.0, y: CGFloat.random(in: 1...9)),
            CGPoint(x: 7.0, y: CGFloat.random(in: 1...9)),
            CGPoint(x: 8.0, y: CGFloat.random(in: 1...9)),
            CGPoint(x: 9.0, y: CGFloat.random(in: 1...9)),
            CGPoint(x: 10.0, y: CGFloat.random(in: 1...9))]
        let belowPoints = points.map { CGPoint(x: $0.x, y: $0.y - 1.0) }
        let abovePoints = points.map { CGPoint(x: $0.x, y: $0.y + 1.0) }
        let main = KArea.Line(points: points, appearance: appearance, style: .solid(width: 2.0, color: .black))
        let below = KArea.Line(points: belowPoints, appearance: appearance, style: .solid(width: 1.0, color: .red))
        let above = KArea.Line(points: abovePoints, appearance: appearance, style: .solid(width: 1.0, color: .blue))
        return (main, below, above)
    }
}

// MARK: - Preview
#if DEBUG
#Preview {
    KLineChartPreview()
}
#endif
// swiftlint:disable:this file_length
