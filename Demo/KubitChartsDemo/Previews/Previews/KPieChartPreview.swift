import KubitCharts
import SwiftUI

struct KPieChartPreview: View {
    var body: some View {
        ScrollView {
            variants
            options
            layout
        }
    }
}

// MARK: - Variants
private extension KPieChartPreview {
    var variants: some View {
        Group {
            regular
            amount
        }
    }

    var regular: some View {
        KPieChartSection(numberOfSegments: 2, sectionTitle: "Regular")
    }

    var amount: some View {
        KPieChartSection(numberOfSegments: 2, label: "0%", sectionTitle: "Amount")
    }
}

// MARK: - Options
private extension KPieChartPreview {
    var options: some View {
        Group {
            withLabel
            withIcon
            error
            customWidth
            allElements
        }
    }

    var withLabel: some View {
        KPieChartSection(numberOfSegments: 3, label: "Label", sectionTitle: "With Label")
    }

    var withIcon: some View {
        KPieChartSection(numberOfSegments: 3, sectionTitle: "With Icon")
    }

    var error: some View {
        KPieChartSection(numberOfSegments: 1, label: "N/A", sectionTitle: "Error")
    }

    var allElements: some View {
        ForEach(1...10, id: \.self) { index in
            KPieChartSection(numberOfSegments: index, sectionTitle: "\(index) elements")
        }
    }

    var customWidth: some View {
        KPieChartSection(numberOfSegments: 5, lineWidth: 40, sectionTitle: "Custom Width")
    }
}

// MARK: - Layout
private extension KPieChartPreview {
    var layout: some View {
        Group {
            fullSegment
            halfPieChart
        }
    }

    var fullSegment: some View {
        KPieChartSection(icon: nil, numberOfSegments: 5, donut: false, sectionTitle: "Full width segment")
    }

    var halfPieChart: some View {
        KPieChartSection(numberOfSegments: 4, isHalfPieChart: true, sectionTitle: "Half pie chart")
    }
}

// MARK: - KPieChart Section
private struct KPieChartSection: View {
    var icon: KImageResource? = KImage.LocalResource(name: "icon_brand_placeholder")
    var numberOfSegments: Int = 3
    var donut: Bool = true
    var label: String?
    var lineWidth: CGFloat = 20
    var isHalfPieChart: Bool = false
    var sectionTitle: String = ""

    var body: some View {
        KPreview {
            VStack {
                Text(sectionTitle)
                    .font(.caption)
                    .bold()
                KPieChart(segments: segments, font: .caption, identifier: "\(KPieChart.self)Identifier")
                    .lineWidth(lineWidth)
                    .isHalfPieChart(isHalfPieChart)
                    .icon(!isLabelEnabled ? icon : nil)
                    .label(label)
                    .accessibilityLabel("\(sectionTitle) Pie Chart")
                    .isDonut(donut ? true : false)
                    .bottomContentPadding(isHalfPieChart ? 40 : 0)
                    .backgroundColor(Color.white)
                    .separatorWidth(5)
                    .separatorColor(Color.white)
                    .frame(width: 200, height: 200)
            }
        }
    }
}

private extension KPieChartSection {
    var allAvailableSegments: [KPieChart.Segment] {
        let value = Double(Int.random(in: 1...10))
        return KPieChart.Segment.PresetColor.allColors.map { color in
                .preset(color, value: value)
                .accessibilityLabel("Segment")
                .accessibilityValue("with value: \(value)")
                .accessibilityHint("This is a hint example.")
        }
    }

    var segments: [KPieChart.Segment] {
        Array(allAvailableSegments.prefix(numberOfSegments))
    }

    var isLabelEnabled: Bool {
        label != nil
    }
}

extension KPieChart.Segment.PresetColor {
    // All preset colors
    static let allColors: [KPieChart.Segment.PresetColor] = [
        .orange, .coral, .pink, .fuchsia, .purple, .blue, .cyan, .mint, .green, .pistachio, .yellow, .sand
    ]
}

// MARK: - Preview
#if DEBUG
#Preview {
    KPieChartPreview()
}
#endif
