import KubitCharts
import SwiftUI

struct KLegendChartPreview: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                variants
                options
            }
        }
        .background(Color(hex: "#F0F0F0") ?? .white)
    }
}

// MARK: - Variants
private extension KLegendChartPreview {
    var variants: some View {
        VStack {
            Text("Variants")
                .font(.largeTitle)
            start
            end
            horizontalStart
            horizontalEnd
        }
    }

    var start: some View {
        LegendSection(
            title: "TITLE",
            value: "##########",
            secondaryValue: "##########",
            color: .red,
            sectionTitle: "Vertical Start (Leading aligned)")
    }

    var end: some View {
        LegendSection(
            title: "TITLE",
            value: "##########",
            secondaryValue: "##########",
            color: .red,
            titleAlignment: .end,
            sectionTitle: "Vertical End (Trailing aligned)")
    }

    var horizontalStart: some View {
        LegendSection(
            title: "TITLE",
            value: "##########",
            secondaryValue: "##########",
            color: .red,
            orientation: .horizontal(),
            sectionTitle: "Horizontal Aligned (Leading aligned)")
    }

    var horizontalEnd: some View {
        LegendSection(
            title: "TITLE",
            value: "##########",
            secondaryValue: "##########",
            color: .red,
            titleAlignment: .end,
            orientation: .horizontal(),
            sectionTitle: "Horizontal Aligned (Trailing aligned)")
    }
}

// MARK: - Options
private extension KLegendChartPreview {
    var options: some View {
        VStack {
            Text("Options")
                .font(.largeTitle)
            noColor
            obfuscated
        }
    }

    var noColor: some View {
        LegendSection(
            title: "TITLE",
            value: "##########",
            secondaryValue: "##########",
            titleAlignment: .start,
            sectionTitle: "No color")
    }

    var obfuscated: some View {
        LegendSection(
            title: "TITLE",
            value: "····€",
            secondaryValue: "····€",
            color: .pink,
            titleAlignment: .end,
            isObfuscated: true,
            sectionTitle: "Obfuscated")
    }
}

// MARK: - Legend Section
private struct LegendSection: View {
    var title: String = "Title"
    var value: String?
    var secondaryValue: String?
    var color: Color?
    var colorSize = CGSize(width: 16.0, height: 12.0)
    var colorCornerRadius: CGFloat = 6.0
    var font: Font = .system(size: 14.0, weight: .regular)
    var fontColor: Color = .black
    var titleAlignment: KLegend.TitleAlignment = .start
    var orientation: KLegend.Orientation = .vertical
    var isObfuscated = false
    var sectionTitle: String

    var body: some View {
        KPreview {
            VStack(spacing: .zero) {
                Text(sectionTitle)
                    .font(.headline)

                KLegend(title: title, accessibilityIdentifier: "\(title).Identifier")
                    .value(value, secondaryValue: secondaryValue)
                    .colorView(color, size: colorSize, cornerRadius: colorCornerRadius)
                    .titleFont(font, color: fontColor)
                    .valuesFont(isObfuscated ? .system(size: 18.0) : .system(size: 16.0))
                    .titleAlignment(titleAlignment)
                    .orientation(orientation)
                    .frame(height: 100)
            }
        }
    }
}

// MARK: - Preview
#if DEBUG
#Preview {
    KLegendChartPreview()
}
#endif
