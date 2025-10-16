public import SwiftUI

/// #  KPieChart.
///
/// A PieChart visually divides numerical data into slices of a circle, illustrating how each component contributes to the whole. It effectively highlights the proportions of each segment, making it easy to understand the overall distribution of the data.
///
/// ## How to use it:
/// ```
///  KPieChart(segments: segments, font: .caption, identifier: "Identifier")
///      .backgroundColor(.white)
///      .borderWidth(borderWidth)
///      .innerBorderColor(.blue)
///      .separatorColor(.pink)
///      .isHalfPieChart(true)
///      .bottomContentPadding(8)
///      .icon(...)
///      .label(label)
/// ```
///
/// This component also supports accessibility.
public struct KPieChart: View {
    @State var chartSize: CGFloat?
    @ObservedObject var model: Model

    private typealias SliceData = KSlice.SliceData

    /// It initializes ``KPieChart`` view with segments, font, and accessibility identifier.
    /// - Parameters:
    ///   - segments: array of segments for the chart.
    ///   - font: font style to be shown on the component.
    ///   - identifier: a unique identifier for the accessibility component.
    public init(segments: [Segment], font: Font, identifier: String) {
        self.model = Model(
                    configuration: Configuration(segments: segments),
                    style: StyleConfiguration(font: font),
                    accessibility: Accessibility(identifier: identifier))
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(slicesData.indices, id: \.self) { index in
                    KSlice(chartSize: $chartSize, sliceData: self.slicesData[index])
                }
                .frame(width: geometry.size.width, height: geometry.size.height)

                innerBorderColor(geometry.size)
                innerBackgroundView(geometry.size)

                mainContent
                    .padding(.bottom, style.bottomContentPadding)
            }
            .frame(width: chartSize, height: chartSize)
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(accessibility.identifier)
            .accessibilityLabel(accessibility.label ?? "")
            .accessibilityValue(accessibility.value ?? "")
            .accessibilityHint(accessibility.hint ?? "")
        }
    }
}

// MARK: - Inner Views
private extension KPieChart {
    @ViewBuilder
    func innerBorderColor(_ size: CGSize) -> some View {
        Circle()
            .trim(from: isHalfPieChart ? 0.5 : 0, to: 1)
            .fill(style.innerBorderColor ?? .clear)
            .frame(
                width: max(0, size.width - radiusBorderSize),
                height: max(0, abs(size.height - radiusBorderSize)))
    }

    @ViewBuilder
    func innerBackgroundView(_ size: CGSize) -> some View {
        Circle()
            .trim(from: isHalfPieChart ? 0.5 : 0, to: 1)
            .fill(style.backgroundColor ?? .clear)
            .frame(
                width: max(0, size.width - radiusBorderSize - innerBackgroundPadding),
                height: max(0, abs(size.height - radiusBorderSize - innerBackgroundPadding)))
    }

    @ViewBuilder var labelView: some View {
        if let label = configuration.label {
            let styleConfiguration = StyleConfiguration(font: .caption)
            Text(label)
                .font(styleConfiguration.font)
                .accessibilityIdentifier(accessibility.labelIdentifier)
        }
    }

    @ViewBuilder var mainContent: some View {
        if isLabelEnabled {
            labelView
        }
        iconView
    }

    @ViewBuilder var iconView: some View {
        if let icon = configuration.icon {
            KImage(resource: icon)
                .accessibilityIdentifier(accessibility.iconIdentifier)
        }
    }
}

// MARK: - Shortcuts
private extension KPieChart {
    var configuration: Configuration {
        self.model.configuration
    }

    var style: StyleConfiguration {
        self.model.style
    }

    var accessibility: Accessibility {
        self.model.accessibility
    }

    var segments: [Segment] {
        configuration.segments.sorted {
            $0.value > $1.value
        }
    }

    var isLabelEnabled: Bool {
        configuration.label != nil
    }

    // Outer circle border size
    var radiusBorderSize: CGFloat {
        10 * style.borderWidth
    }

    // Inner circle container border size
    var innerBackgroundPadding: CGFloat {
        12 * style.borderWidth
    }

    var isHalfPieChart: Bool {
        style.isHalfPieChart
    }
}

// MARK: - Helper
private extension KPieChart {
    // Slices data
    private var slicesData: [SliceData] {
        var separators: Int {
            segments.count > 1 ? segments.count : 0
        }

        var totalAmount: Double {
            let slicesAmount = segments
                .map { $0.value }
                .reduce(0, +)
            var spacingAmount = slicesAmount
            for _ in .zero..<separators {
                spacingAmount *= (101 / 100)
            }

            return segments.isEmpty ? 1 : spacingAmount
        }

        var auxiliarSegments: [KPieChart.Segment] {
            var auxiliarSegments: [KPieChart.Segment] = []

            if segments.isEmpty {
                return [KPieChart.Segment(value: 1, color: .gray)]
            }

            let separator = KPieChart.Segment(value: totalAmount * 1 / 100, color: style.separatorColor ?? .clear)

            segments.forEach { slice in
                auxiliarSegments.append(slice)
                auxiliarSegments.append(separator)
            }
            return auxiliarSegments
        }

        var endDegrees: Double = isHalfPieChart ? -90 : 0
        var slicesData: [SliceData] = []

        auxiliarSegments.forEach { segment in
            let totalDegrees: Double = isHalfPieChart ? 179.7 : 360
            let degrees: Double = segment.value * totalDegrees / totalAmount
            slicesData.append(SliceData(
                startAngle: Angle(degrees: endDegrees),
                endAngle: Angle(degrees: endDegrees + degrees),
                segment: segment))
            endDegrees += degrees
        }
        return slicesData
    }
}
