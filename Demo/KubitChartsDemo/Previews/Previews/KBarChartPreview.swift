import KubitCharts
import SwiftUI

struct KBarChartPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                variants
                appearance
                orientation
                value
                options
            }
        }
        .background(Color(hex: "#F0F0F0") ?? .white)
    }
}

// MARK: - Variants
private extension KBarChartPreview {
    var variants: some View {
        VStack {
            Text("Variants")
                .font(.largeTitle)
            regular
            stacked
        }
    }

    var regular: some View {
        KBarChartSection(
            title: "Regular",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(-1.5...1.5),
            bars: [
                bar(
                    orientation: .horizontal,
                    segments: [segment(10.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))])
            ],
            height: 48.0)
    }

    var stacked: some View {
        KBarChartSection(
            title: "Stacked",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(-1.5...1.5),
            bars: [
                bar(
                    orientation: .horizontal,
                    segments: [
                        segment(
                            1.0,
                            identifier: "1",
                            color: Color(red: 0.25, green: 0.32, blue: 0.71),
                            corners: .leadingRoundedOnly(4.0)),
                        segment(1.0, identifier: "2", color: Color(red: 0.69, green: 0.12, blue: 0.36)),
                        segment(3.25, identifier: "3", color: Color(red: 0.4, green: 0.23, blue: 0.72)),
                        segment(1.5, identifier: "4", color: Color(red: 0.04, green: 0.63, blue: 0.51)),
                        segment(
                            3.25,
                            identifier: "5",
                            color: Color(red: 0.8, green: 0.44, blue: 0.25),
                            corners: .trailingRoundedOnly(4.0))
                    ])
            ],
            height: 48.0)
    }
}

// MARK: - Appearance
private extension KBarChartPreview {
    var appearance: some View {
        VStack {
            Text("Appearance")
                .font(.largeTitle)
            square
            mixed
            rounded
        }
    }

    var square: some View {
        KBarChartSection(
            title: "Square",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(-1.5...1.5),
            bars: [
                bar(
                    orientation: .horizontal,
                    segments: [
                        segment(1.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71)),
                        segment(1.0, identifier: "2", color: Color(red: 0.69, green: 0.12, blue: 0.36)),
                        segment(3.25, identifier: "3", color: Color(red: 0.4, green: 0.23, blue: 0.72)),
                        segment(1.5, identifier: "4", color: Color(red: 0.04, green: 0.63, blue: 0.51)),
                        segment(3.25, identifier: "5", color: Color(red: 0.8, green: 0.44, blue: 0.25))])
            ],
            height: 48.0)
    }

    var mixed: some View {
        KBarChartSection(
            title: "Mixed",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(-1.5...1.5),
            bars: [
                bar(
                    orientation: .horizontal,
                    segments: [
                        segment(1.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71)),
                        segment(1.0, identifier: "2", color: Color(red: 0.69, green: 0.12, blue: 0.36)),
                        segment(3.25, identifier: "3", color: Color(red: 0.4, green: 0.23, blue: 0.72)),
                        segment(1.5, identifier: "4", color: Color(red: 0.04, green: 0.63, blue: 0.51)),
                        segment(
                            3.25,
                            identifier: "5",
                            color: Color(red: 0.8, green: 0.44, blue: 0.25),
                            corners: .trailingRoundedOnly(4.0))
                    ])
            ],
            height: 48.0)
    }

    var rounded: some View {
        KBarChartSection(
            title: "Rounded",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(-1.5...1.5),
            bars: [
                bar(
                    orientation: .horizontal,
                    segments: [
                        segment(
                            1.0,
                            identifier: "1",
                            color: Color(red: 0.25, green: 0.32, blue: 0.71),
                            corners: .rounded()),
                        segment(
                            1.0,
                            identifier: "2",
                            color: Color(red: 0.69, green: 0.12, blue: 0.36),
                            corners: .rounded()),
                        segment(
                            3.25,
                            identifier: "3",
                            color: Color(red: 0.4, green: 0.23, blue: 0.72),
                            corners: .rounded()),
                        segment(
                            1.5,
                            identifier: "4",
                            color: Color(red: 0.04, green: 0.63, blue: 0.51),
                            corners: .rounded()),
                        segment(
                            3.25,
                            identifier: "5",
                            color: Color(red: 0.8, green: 0.44, blue: 0.25),
                            corners: .rounded())
                    ])
            ],
            height: 48.0)
    }
}

// MARK: - Orientation
private extension KBarChartPreview {
    var orientation: some View {
        VStack {
            Text("Orientation")
                .font(.largeTitle)
            vertical
        }
    }

    var vertical: some View {
        KBarChartSection(
            title: "Vertical",
            xAxis: SBAxisHelper.clearAxis(0...5),
            yAxis: SBAxisHelper.clearAxis(),
            bars: [
                bar(
                    orientation: .vertical,
                    origin: 1.0,
                    width: 0.25,
                    segments: [segment(10.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))]),
                bar(
                    orientation: .vertical,
                    origin: 4.0,
                    width: 0.25,
                    segments: [
                        segment(
                            1.0,
                            identifier: "1",
                            color: Color(red: 0.25, green: 0.32, blue: 0.71),
                            corners: .bottomRoundedOnly(6.0)),
                        segment(1.0, identifier: "2", color: Color(red: 0.69, green: 0.12, blue: 0.36)),
                        segment(3.25, identifier: "3", color: Color(red: 0.4, green: 0.23, blue: 0.72)),
                        segment(1.5, identifier: "4", color: Color(red: 0.04, green: 0.63, blue: 0.51)),
                        segment(
                            3.25,
                            identifier: "5",
                            color: Color(red: 0.8, green: 0.44, blue: 0.25),
                            corners: .topRoundedOnly(6.0))
                    ])
            ],
            height: 300.0)
    }
}

// MARK: - Value
private extension KBarChartPreview {
    var value: some View {
        VStack {
            Text("Value")
                .font(.largeTitle)

            horizontalRegularSimple
            horizontalRegularStacked
            horizontalRegularGrouped
            verticalRegularSimple
            verticalRegularStacked
            verticalRegularGrouped
        }
    }

    var horizontalRegularSimple: some View {
        KBarChartSection(
            title: "Horizontal Regular / Simple",
            xAxis: zeroXAxis,
            yAxis: defaultYAxis,
            bars: [
                bar(
                    orientation: .horizontal,
                    origin: 1.0,
                    width: 0.22,
                    segments: [segment(8.3, identifier: "1", color: Color(red: 0.02, green: 0.6, blue: 0.87))]),
                bar(
                    orientation: .horizontal,
                    origin: -1.0,
                    width: 0.22,
                    segments: [segment(4.9, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))])
            ],
            addNegativeShadeRegions: true)
    }

    var horizontalRegularStacked: some View {
        KBarChartSection(
            title: "Horizontal Regular / Stacked",
            xAxis: zeroXAxis,
            yAxis: defaultYAxis,
            bars: [
                bar(
                    orientation: .horizontal,
                    origin: 1.0,
                    width: 0.22,
                    segments: [
                        segment(1.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71)),
                        segment(1.0, identifier: "2", color: Color(red: 0.69, green: 0.12, blue: 0.36)),
                        segment(0.75, identifier: "3", color: Color(red: 0.4, green: 0.23, blue: 0.72)),
                        segment(1.5, identifier: "4", color: Color(red: 0.04, green: 0.63, blue: 0.51)),
                        segment(3.25, identifier: "5", color: Color(red: 0.8, green: 0.44, blue: 0.25))]),
                bar(
                    orientation: .horizontal,
                    origin: -1.0,
                    width: 0.22,
                    segments: [
                        segment(1.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71)),
                        segment(1.0, identifier: "2", color: Color(red: 0.69, green: 0.12, blue: 0.36)),
                        segment(1.75, identifier: "3", color: Color(red: 0.4, green: 0.23, blue: 0.72)),
                        segment(1.5, identifier: "4", color: Color(red: 0.04, green: 0.63, blue: 0.51)),
                        segment(3.25, identifier: "5", color: Color(red: 0.8, green: 0.44, blue: 0.25))])
            ],
            addNegativeShadeRegions: true)
    }

    var horizontalRegularGrouped: some View {
        KBarChartSection(
            title: "Horizontal Regular / Grouped",
            xAxis: zeroXAxis,
            yAxis: defaultYAxis,
            bars: [
                bar(
                    orientation: .horizontal,
                    origin: 1.0,
                    width: 0.22,
                    segments: [
                        segment(6.0, identifier: "1", color: Color(red: 0.02, green: 0.6, blue: 0.87))]),
                bar(
                    orientation: .horizontal,
                    origin: 1.22,
                    width: 0.22,
                    segments: [
                        segment(4.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))]),
                bar(
                    orientation: .horizontal,
                    origin: -1.0,
                    width: 0.22,
                    segments: [
                        segment(8.3, identifier: "1", color: Color(red: 0.02, green: 0.6, blue: 0.87))]),
                bar(
                    orientation: .horizontal,
                    origin: -1.22,
                    width: 0.22,
                    segments: [
                        segment(4.9, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))])
            ],
            addNegativeShadeRegions: true)
    }

    var verticalRegularSimple: some View {
        KBarChartSection(
            title: "Vertical Regular / Simple",
            xAxis: defaultXAxis,
            yAxis: defaultYAxis,
            bars: [
                bar(
                    orientation: .vertical,
                    origin: 1.0,
                    width: 0.22,
                    segments: [segment(3.3, identifier: "1", color: Color(red: 0.02, green: 0.6, blue: 0.87))]),
                bar(
                    orientation: .vertical,
                    origin: 2.0,
                    width: 0.22,
                    segments: [segment(1.78, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))],
                    initialOffset: -1.75)
            ],
            addNegativeShadeRegions: true)
    }

    var verticalRegularStacked: some View {
        KBarChartSection(
            title: "Vertical Regular / Stacked",
            xAxis: defaultXAxis,
            yAxis: defaultYAxis,
            bars: [
                bar(
                    orientation: .vertical,
                    origin: 2.0,
                    width: 0.22,
                    segments: [
                        segment(1.0, identifier: "1", color: Color(red: 1, green: 0.37, blue: 0.06)),
                        segment(1.3, identifier: "2", color: Color(red: 0.69, green: 0.12, blue: 0.36))],
                    initialOffset: -2.3),
                bar(
                    orientation: .vertical,
                    origin: 3.0,
                    width: 0.22,
                    segments: [
                        segment(1.4, identifier: "1", color: Color(red: 0.69, green: 0.12, blue: 0.36)),
                        segment(0.15, identifier: "2", color: Color(red: 0.4, green: 0.23, blue: 0.72)),
                        segment(1.78, identifier: "3", color: Color(red: 0.04, green: 0.63, blue: 0.51)),
                        segment(0.3, identifier: "4", color: Color(red: 1, green: 0.37, blue: 0.06))])
            ],
            addNegativeShadeRegions: true)
    }

    var verticalRegularGrouped: some View {
        KBarChartSection(
            title: "Vertical Regular / Grouped",
            xAxis: defaultXAxis,
            yAxis: defaultYAxis,
            bars: [
                bar(
                    orientation: .vertical,
                    origin: 0.88,
                    width: 0.22,
                    segments: [segment(3.3, identifier: "1", color: Color(red: 0.02, green: 0.6, blue: 0.87))]),
                bar(
                    orientation: .vertical,
                    origin: 1.12,
                    width: 0.22,
                    segments: [segment(1.7, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))]),
                bar(
                    orientation: .vertical,
                    origin: 1.88,
                    width: 0.22,
                    segments: [segment(-1.88, identifier: "1", color: Color(red: 0.02, green: 0.6, blue: 0.87))]),
                bar(
                    orientation: .vertical,
                    origin: 2.12,
                    width: 0.22,
                    segments: [segment(1.78, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))],
                    initialOffset: -1.75)
            ],
            addNegativeShadeRegions: true)
    }
}

// MARK: - Data
private extension KBarChartPreview {
    var zeroXAxis: KAxis {
        KAxisBuilder()
            .addPoint(0, labelStyle: .none, lineStyle: .solid(color: .black))
            .addPointWithClearLine(10.0)
            .setLabelsViewPosition(.none)
            .build()
    }

    func bar(orientation: KBar.Orientation,
             origin: CGFloat = .zero,
             width: CGFloat = 1.0,
             segments: [KBar.Segment],
             initialOffset: CGFloat = .zero,
             labelStyle: KBar.LabelStyle = .none) -> KBar {
        if orientation == .horizontal {
            .horizontal(
                origin: origin,
                height: width,
                segments: segments,
                xOffset: initialOffset,
                labelStyle: labelStyle,
                accessibilityIdentifier: "SingleBarIdentifier",
                accessibilityLabel: "Single bar")
        } else {
            .vertical(
                origin: origin,
                width: width,
                segments: segments,
                yOffset: initialOffset,
                labelStyle: labelStyle,
                accessibilityIdentifier: "SingleBarIdentifier",
                accessibilityLabel: "Single bar")
        }
    }

    func segment(_ value: CGFloat,
                 identifier: String,
                 color: Color,
                 corners: KBar.Segment.Style.CornerRadius = .square) -> KBar.Segment {
        KBar.Segment(
            identifier: identifier,
            value: value,
            style: KBar.Segment.Style(color: color, corners: corners),
            accessibilityLabel: "Segment accessibility label.",
            accessibilityValue: "\(value) points")
    }

    var defaultXAxis: KAxis {
        KAxisBuilder()
            .setLabelsViewPosition(.end)
            .addPoint(
                0,
                labelStyle: .labeled("V0", color: .black),
                lineStyle: .solid(color: .black))
            .addPoint(
                1,
                labelStyle: .labeled("VY", color: .black),
                lineStyle: .dashed(color: Color(red: 0.8, green: 0.8, blue: 0.8)))
            .addPoint(
                2,
                labelStyle: .labeled("VY", color: .black),
                lineStyle: .dashed(color: Color(red: 0.8, green: 0.8, blue: 0.8)))
            .addPoint(
                3,
                labelStyle: .labeled("VY", color: .black),
                lineStyle: .dashed(color: Color(red: 0.8, green: 0.8, blue: 0.8)))
            .addPoint(
                4,
                labelStyle: .labeled("VY", color: .black),
                lineStyle: .dashed(color: Color(red: 0.8, green: 0.8, blue: 0.8)))
            .addPoint(
                5,
                labelStyle: .labeled("VY", color: .black),
                lineStyle: .dashed(color: Color(red: 0.8, green: 0.8, blue: 0.8)))
            .addPoint(6, labelStyle: .none, lineStyle: .none)
            .build()
    }

    var defaultYAxis: KAxis {
        KAxisBuilder()
            .setLabelsViewPosition(.start)
            .addPoint(-3, labelStyle: .labeled("-VY", color: .black), lineStyle: .solid(color: .black))
            .addPoint(
                -2,
                labelStyle: .labeled("-VY", color: .black),
                lineStyle: .dashed(color: Color(red: 0.8, green: 0.8, blue: 0.8)))
            .addPoint(
                -1,
                labelStyle: .labeled("-VY", color: .black),
                lineStyle: .dashed(color: Color(red: 0.8, green: 0.8, blue: 0.8)))
            .addPoint(
                0,
                labelStyle: .labeled("V0", color: .black),
                lineStyle: .solid(color: .black))
            .addPoint(
                1,
                labelStyle: .labeled("VY", color: .black),
                lineStyle: .dashed(color: Color(red: 0.8, green: 0.8, blue: 0.8)))
            .addPoint(
                2,
                labelStyle: .labeled("VY", color: .black),
                lineStyle: .dashed(color: Color(red: 0.8, green: 0.8, blue: 0.8)))
            .addPoint(
                3,
                labelStyle: .labeled("VY", color: .black),
                lineStyle: .dashed(color: Color(red: 0.8, green: 0.8, blue: 0.8)))
            .addPoint(3.5, labelStyle: .none, lineStyle: .none)
            .build()
    }
}

// MARK: - Options
private extension KBarChartPreview {
    var options: some View {
        VStack {
            Text("Options")
                .font(.largeTitle)
            topLeadingLabel
            topTrailingLabel
            bottomLeadingLabel
            bottomTrailingLabel
            topLabel
            bottomLabel
        }
    }

    var topLeadingLabel: some View {
        KBarChartSection(
            title: "Top / Left",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(-3...6),
            bars: [
                bar(
                    orientation: .horizontal,
                    segments: [segment(10.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))],
                    labelStyle: .labeled("Lorem ipsum", color: .black))
            ],
            height: 50.0)
    }

    var topTrailingLabel: some View {
        KBarChartSection(
            title: "Top / Right",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(-3...6),
            bars: [
                bar(
                    orientation: .horizontal,
                    segments: [segment(10.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))],
                    labelStyle: .labeled("Lorem ipsum", color: .black, position: .topTrailing))
            ],
            height: 50.0)
    }

    var bottomLeadingLabel: some View {
        KBarChartSection(
            title: "Bottom / Left",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(-6...3),
            bars: [
                bar(
                    orientation: .horizontal,
                    segments: [segment(10.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))],
                    labelStyle: .labeled("Lorem ipsum", color: .black, position: .bottomLeading))
            ],
            height: 50.0)
    }

    var bottomTrailingLabel: some View {
        KBarChartSection(
            title: "Bottom / Right",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(-6...3),
            bars: [
                bar(
                    orientation: .horizontal,
                    segments: [segment(10.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))],
                    labelStyle: .labeled("Lorem ipsum", color: .black, position: .bottomTrailing))
            ],
            height: 50.0)
    }

    var topLabel: some View {
        KBarChartSection(
            title: "Top",
            xAxis: SBAxisHelper.clearAxis(0...6),
            yAxis: SBAxisHelper.clearAxis(0...15),
            bars: [
                bar(
                    orientation: .vertical,
                    origin: 3.0,
                    width: 0.3,
                    segments: [segment(6.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))],
                    labelStyle: .labeled("Lorem ipsum", color: .black, position: .top))
            ])
    }

    var bottomLabel: some View {
        KBarChartSection(
            title: "Top",
            xAxis: SBAxisHelper.clearAxis(0...6),
            yAxis: SBAxisHelper.clearAxis(0...15),
            bars: [
                bar(
                    orientation: .vertical,
                    origin: 3.0,
                    width: 0.3,
                    segments: [segment(6.0, identifier: "1", color: Color(red: 0.25, green: 0.32, blue: 0.71))],
                    initialOffset: 10.0,
                    labelStyle: .labeled("Lorem ipsum", color: .black, position: .bottom))
            ])
    }
}

// MARK: - Section View
private struct KBarChartSection: View {
    var title: String
    var xAxis: KAxis
    var yAxis: KAxis
    var bars: [KBar]
    var height: CGFloat = 300.0
    var addNegativeShadeRegions = false

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)

            barChart
                .background(Color.white)
                .kRadius(12.0)
                .padding(.horizontal, 12.0)
        }
    }

    @ViewBuilder var barChart: some View {
        let chart = KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
            .addBars(bars)
        if addNegativeShadeRegions {
            chart
                .addNegativeShadeRegions(color: Color.black.opacity(0.08))
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .padding(.leading, xAxis.startPadding)
                .padding(.top, yAxis.startPadding)
                .padding(.trailing, xAxis.endPadding)
                .padding(.bottom, yAxis.endPadding)
        } else {
            chart
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .padding(.leading, xAxis.startPadding)
                .padding(.top, yAxis.startPadding)
                .padding(.trailing, xAxis.endPadding)
                .padding(.bottom, yAxis.endPadding)
        }
    }
}

#if DEBUG
#Preview {
    KBarChartPreview()
}
#endif
// swiftlint:disable:this file_length
