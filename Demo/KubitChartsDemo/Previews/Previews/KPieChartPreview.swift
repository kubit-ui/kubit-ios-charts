import KubitCharts
import SwiftUI

struct KPieChartPreview: View {
    var body: some View {
        ScrollView {
            variants
            states
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
        KPieChartSection(numberOfSegments: 3, sectionTitle: "Regular")
    }

    var amount: some View {
        KPieChartSection(numberOfSegments: 2, sectionTitle: "Amount")
    }
}

// MARK: - States
private extension KPieChartPreview {
    var states: some View {
        Group {
            regularEmpty
            regularError
            regularFilled
            amountEmpty
            amountError
            amountFilled
        }
    }

    var regularEmpty: some View {
        KPieChartSection(numberOfSegments: 0, sectionTitle: "Regular empty")
    }

    var regularError: some View {
        KPieChartSection(error: true, sectionTitle: "Regular error")
    }

    var regularFilled: some View {
        KPieChartSection(sectionTitle: "Regular filled")
    }

    var amountEmpty: some View {
        KPieChartSection(numberOfSegments: 0, label: "N/A", sectionTitle: "Amount empty")
    }

    var amountError: some View {
        KPieChartSection(error: true, label: "N/A", sectionTitle: "Amount error")
    }

    var amountFilled: some View {
        KPieChartSection(label: "N/A", sectionTitle: "Amount filled")
    }
}

// MARK: - Options
private extension KPieChartPreview {
    var options: some View {
        Group {
            withLabel
            withIcon
            error
            empty
            allElements
        }
    }

    var withLabel: some View {
        KPieChartSection(numberOfSegments: 3, label: "Label", sectionTitle: "With Label")
    }

    var withIcon: some View {
        KPieChartSection(numberOfSegments: 3, sectionTitle: "With Icon")
    }

    var empty: some View {
        KPieChartSection(numberOfSegments: 0, sectionTitle: "Error")
    }

    var error: some View {
        KPieChartSection(numberOfSegments: 0, label: "N/A", sectionTitle: "Error")
    }

    var allElements: some View {
        ForEach(0...12, id: \.self) { index in
            KPieChartSection(numberOfSegments: index, sectionTitle: "\(index) elements")
        }
    }
}

// MARK: - Layout
private extension KPieChartPreview {
    var layout: some View {
        Group {
            thinSegment
            halfWidthSegment
            fullSegment
            halfPieChart
            errorHalfPieChart
        }
    }

    var thinSegment: some View {
        KPieChartSection(sectionTitle: "Thin segment")
    }

    var halfWidthSegment: some View {
        KPieChartSection(
            innerBorderColor: Color.white,
            borderWidth: 7,
            sectionTitle: "Half width segment")
    }

    var fullSegment: some View {
        KPieChartSection(icon: nil, borderWidth: 30, sectionTitle: "Full width segment")
    }

    var halfPieChart: some View {
        KPieChartSection(
            numberOfSegments: 5,
            isHalfPieChart: true,
            bottomContentPadding: 50,
            sectionTitle: "Half pie chart")
    }

    var errorHalfPieChart: some View {
        KPieChartSection(
            numberOfSegments: 0,
            label: "N/A",
            isHalfPieChart: true,
            bottomContentPadding: 50,
            sectionTitle: "Error half pie chart")
    }
}

// MARK: - KPieChart Section
private struct KPieChartSection: View {
    var icon: KImageResource? = KImage.LocalResource(name: "icon_brand_placeholder")
    var parentBackgroundColor: Color = .white
    var innerBorderColor: Color = .gray
    var numberOfSegments: Int = 3
    var error: Bool = false
    var label: String?
    var borderWidth: CGFloat = 1
    var isHalfPieChart: Bool = false
    var bottomContentPadding: CGFloat = 0
    var sectionTitle: String = ""

    var body: some View {
        KPreview {
            VStack {
                Text(sectionTitle)
                    .font(.caption)
                    .bold()
                KPieChart(segments: segments, font: .caption, identifier: "\(KPieChart.self)Identifier")
                    .backgroundColor(.white)
                    .borderWidth(borderWidth)
                    .innerBorderColor(innerBorderColor)
                    .separatorColor(.blue)
                    .isHalfPieChart(isHalfPieChart)
                    .bottomContentPadding(bottomContentPadding)
                    .icon(!isLabelEnabled ? icon : nil)
                    .label(label)
                    .frame(width: 200, height: 200)
            }
        }
    }
}

private extension KPieChartSection {
    var allAvailableSegments: [KPieChart.Segment] {
        KPieChart.Segment.PresetColor.allColors.map { color in
            .preset(color, value: Double(Int.random(in: 1...10)))
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
