import KubitCharts
import SwiftUI

struct KAxisChartPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                variants
                options
                slanted
                layout
            }
        }
        .background(Color(hex: "#F0F0F0") ?? .white)
    }
}

// MARK: - Variants
private extension KAxisChartPreview {
    var variants: some View {
        VStack {
            Text("Variants")
                .font(.largeTitle)
            yAxisLeading
            yAxisEnd
            xAxisBottom
            xAxisTop
        }
    }

    var yAxisLeading: some View {
        KAxisChartSection(
            title: "Y-Axis Leading",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.defaultAxis(position: .start, label0: "V0", label: "VY"))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var yAxisEnd: some View {
        KAxisChartSection(
            title: "Y-Axis Trailing",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.defaultAxis(position: .end, label0: "V0", label: "VY"))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var xAxisBottom: some View {
        KAxisChartSection(
            title: "X-Axis Bottom",
            xAxis: SBAxisHelper.defaultAxis(position: .end, label0: "V0", label: "VX"),
            yAxis: SBAxisHelper.clearAxis())
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var xAxisTop: some View {
        KAxisChartSection(
            title: "X-Axis Top",
            xAxis: SBAxisHelper.defaultAxis(position: .start, label0: "V0", label: "VX"),
            yAxis: SBAxisHelper.clearAxis())
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }
}

// MARK: - Options
private extension KAxisChartPreview {
    var options: some View {
        VStack {
            Text("Options")
                .font(.largeTitle)
            withGuidelines
            withoutGuidelines
            withoutAxisValues
            withAxisXNegativeValues
            withAxisYNegativeValues
        }
    }

    var withGuidelines: some View {
        KAxisChartSection(
            title: "With guidelines",
            xAxis: SBAxisHelper.defaultAxis(position: .end, label0: "V0", label: "VX", addClearLineAtTheEnd: true),
            yAxis: SBAxisHelper.defaultAxis(position: .start, label0: "V0", label: "VY", addClearLineAtTheEnd: true))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var withoutGuidelines: some View {
        KAxisChartSection(
            title: "Without guidelines",
            xAxis: SBAxisHelper.noLinesAxis(position: .end, label0: "V0", label: "VX"),
            yAxis: SBAxisHelper.noLinesAxis(position: .start, label0: "V0", label: "VY"))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var withoutAxisValues: some View {
        KAxisChartSection(
            title: "Without axis values",
            xAxis: SBAxisHelper.noLabelsAxis(position: .end),
            yAxis: SBAxisHelper.noLabelsAxis(position: .start))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var withAxisXNegativeValues: some View {
        KAxisChartSection(
            title: "With axis X negative values",
            xAxis: SBAxisHelper.mixedAxis(position: .end, label0: "V0", label: "VX"),
            yAxis: SBAxisHelper.clearAxis(),
            forceNegative: true)
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var withAxisYNegativeValues: some View {
        KAxisChartSection(
            title: "With axis X negative values",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.mixedAxis(position: .end, label0: "V0", label: "VY"),
            forceNegative: true)
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }
}

// MARK: - Slanted
private extension KAxisChartPreview {
    var slanted: some View {
        VStack {
            Text("Slanted labels")
                .font(.largeTitle)
            slantedX
            slantedY
        }
    }

    var slantedX: some View {
        KAxisChartSection(
            title: "Slandet X",
            xAxis: SBAxisHelper.defaultAxis(position: .end, label0: "V0", label: "VX", addClearLineAtTheEnd: true, slanted: true),
            yAxis: SBAxisHelper.defaultAxis(position: .start, label0: "V0", label: "VY", addClearLineAtTheEnd: true))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var slantedY: some View {
        KAxisChartSection(
            title: "Slandet Y",
            xAxis: SBAxisHelper.defaultAxis(position: .end, label0: "V0", label: "VX", addClearLineAtTheEnd: true),
            yAxis: SBAxisHelper.defaultAxis(
                position: .start,
                label0: "V0",
                label: "VY",
                addClearLineAtTheEnd: true,
                slanted: true))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }
}

// MARK: - Layout
private extension KAxisChartPreview {
    var layout: some View {
        VStack {
            Text("Layout")
                .font(.largeTitle)
            quadrant1
            quadrant2
            quadrant3
            quadrant4
            complex
            minimum
            scrollable
        }
    }

    var quadrant1: some View {
        KAxisChartSection(
            title: "Quadrant 1",
            xAxis: SBAxisHelper.negativeAxis(position: .end, label0: "V0", label: "-VX"),
            yAxis: SBAxisHelper.defaultAxis(position: .end, label0: "V0", label: "VY", addClearLineAtTheEnd: true))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var quadrant2: some View {
        KAxisChartSection(
            title: "Quadrant 2",
            xAxis: SBAxisHelper.defaultAxis(position: .end, label0: "V0", label: "VX", addClearLineAtTheEnd: true),
            yAxis: SBAxisHelper.defaultAxis(position: .start, label0: "V0", label: "VY", addClearLineAtTheEnd: true))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var quadrant3: some View {
        KAxisChartSection(
            title: "Quadrant 3",
            xAxis: SBAxisHelper.defaultAxis(position: .start, label0: "V0", label: "VX", addClearLineAtTheEnd: true),
            yAxis: SBAxisHelper.negativeAxis(position: .start, label0: "V0", label: "-VY"))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var quadrant4: some View {
        KAxisChartSection(
            title: "Quadrant 4",
            xAxis: SBAxisHelper.negativeAxis(position: .start, label0: "V0", label: "-VX"),
            yAxis: SBAxisHelper.negativeAxis(position: .end, label0: "V0", label: "-VY"))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var complex: some View {
        KAxisChartSection(
            title: "Complex",
            xAxis: SBAxisHelper.complexAxis(position: .custom(scaledValue: 0.5, offset: 10.0), label0: "V0", label: "VX"),
            yAxis: SBAxisHelper.complexAxis(position: .custom(scaledValue: 0.5, offset: 4.0), label0: "V0", label: "VY"))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var minimum: some View {
        KAxisChartSection(
            title: "Minimum",
            xAxis: SBAxisHelper.minimumAxis(position: .end, label0: "V0", label: "VX"),
            yAxis: SBAxisHelper.minimumAxis(position: .start, label0: "V0", label: "VY"))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }

    var scrollable: some View {
        KAxisChartSection(
            title: "Scrollable",
            xAxis: SBAxisHelper.scrollableAxis(label0: "V0", label: "VX", offset: 8.0),
            yAxis: SBAxisHelper.scrollableAxis(label0: "V0", label: "VY", offset: 4.0))
        .frame(maxWidth: .infinity)
        .frame(height: 350.0)
    }
}

// MARK: - Section
private struct KAxisChartSection: View {
    var title: String
    var xAxis: KAxis
    var yAxis: KAxis
    var forceNegative = false

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)

            axisChart
                .background(Color.white)
                .kRadius(12.0)
                .padding(.horizontal, 12.0)
        }
    }

    @ViewBuilder var axisChart: some View {
        let chart = KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
        if forceNegative {
            chart
                .addNegativeShadeRegions(color: Color.pink.opacity(0.1))
                .padding(.leading, xAxis.startPadding)
                .padding(.top, yAxis.startPadding)
                .padding(.trailing, xAxis.endPadding)
                .padding(.bottom, yAxis.endPadding)
        } else {
            chart
                .padding(.leading, xAxis.startPadding)
                .padding(.top, yAxis.startPadding)
                .padding(.trailing, xAxis.endPadding)
                .padding(.bottom, yAxis.endPadding)
        }
    }
}

#if DEBUG
#Preview {
    KAxisChartPreview()
}
#endif
