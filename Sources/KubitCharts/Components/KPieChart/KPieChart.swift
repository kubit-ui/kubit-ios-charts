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
///      .separatorColor(.pink)
///      .isHalfPieChart(true)
///      .bottomContentPadding(8)
///      .icon(...)
///      .label(label)
/// ```
///
/// This component also supports accessibility.
public struct KPieChart: View {
    @ObservedObject var model: Model

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
        ZStack {
            ForEach(segments.indices, id: \.self) { index in
                segmentView(index)
            }

            if isLabelEnabled {
                labelView
                    .padding(.bottom, bottomContentPadding)
            }

            if isIconEnabled {
                iconView
                    .padding(.bottom, bottomContentPadding)
            }
        }
        .background(innerBackgroundColor)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibility.label ?? "")
        .accessibilityValue(accessibility.value ?? "")
        .accessibilityHint(accessibility.hint ?? "")
    }
}

// MARK: - Segment Rendering
 private extension KPieChart {
    @ViewBuilder
    func segmentView(_ index: Int) -> some View {
        let angle = angles[index]
        let segmentColor = segments[index].color

        // Segment Shape
        KPieSegment(
            startAngle: angle.start,
            endAngle: angle.end,
            isDonut: isDonut,
            lineWidth: isDonut ? lineWidth : 0)
        .applyStyle(isDonut: isDonut, color: segmentColor, lineWidth: lineWidth)

        // Separator Shape
        if segments.count > 1 {
            KPieSegment(
                startAngle: angle.start,
                endAngle: angle.end,
                isDonut: false,
                lineWidth: 0)
            .stroke(
                separatorColor,
                style: StrokeStyle(
                    lineWidth: separatorWidth,
                    lineCap: .butt,
                    lineJoin: .round))
        }
    }
 }

// MARK: - Inner Views
private extension KPieChart {
    @ViewBuilder var innerBackgroundColor: some View {
        if isDonut {
            Circle()
                .trim(from: 0.0, to: isHalfPieChart ? 0.5 : 1.0)
                .fill(style.backgroundColor ?? .clear)
                .rotationEffect(.degrees(isHalfPieChart ? 180 : 0))
        }
    }

    @ViewBuilder var labelView: some View {
        if let label = configuration.label {
            let styleConfiguration = StyleConfiguration(font: .caption)
            Text(label)
                .font(styleConfiguration.font)
                .accessibilityIdentifier(accessibility.labelIdentifier)
        }
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

    var isIconEnabled: Bool {
        configuration.icon != nil
    }

    var isHalfPieChart: Bool {
        style.isHalfPieChart
    }

    var isDonut: Bool {
        style.isDonut
    }

    var separatorWidth: CGFloat {
        style.separatorWidth
    }

    var separatorColor: Color {
        style.separatorColor ?? .clear
    }

    var lineWidth: CGFloat {
        style.lineWidth
    }

    var bottomContentPadding: CGFloat {
        style.bottomContentPadding
    }
}

// MARK: - Helper
private extension KPieChart {
    var angles: [(start: Angle, end: Angle)] {
        var currentAngle = isHalfPieChart ? -180 : -90.0
        return segments.map { slice in
            let start = currentAngle
            let angle = (isHalfPieChart ? 180 : 360) * (slice.value / total)
            let end = currentAngle + angle
            currentAngle = end
            return (Angle(degrees: start), Angle(degrees: end))
        }
    }

    var total: Double {
        segments.reduce(0) { $0 + $1.value }
    }
}
