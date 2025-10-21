public import SwiftUI

/// Axis data for the model.
public struct KAxis: Equatable {
    /// It defines the behavior of the axis (for example, `.fill` or `.scrollable`).
    public let behavior: KAxis.Behavior
    /// Array of points that represents the axis data.
    public let points: [KAxis.Point]
    /// The style applied to the axis labels.
    public let labelsStyle: KAxis.LabelsStyle
    /// The style applied to the axis lines.
    public let linesStyle: KAxis.LinesStyle

    /// It defines the inner padding at the start of the axis.
    public var startInnerPadding: CGFloat = .zero
    /// It defines the inner padding at the end of the axis.
    public var endInnerPadding: CGFloat = .zero

    /// Axis data initializer.
    /// - Parameters:
    ///   - behavior: behavior of the axis. `.fill` by default.
    ///   - points: array of axis points. Empty by default.
    ///   - labelsStyle: style for labels view inside the axis (if present).
    ///   - linesStyle: style for inner lines (if present).
    public init(behavior: KAxis.Behavior = .fill,
                points: [KAxis.Point] = [],
                labelsStyle: KAxis.LabelsStyle = KAxis.LabelsStyle(),
                linesStyle: KAxis.LinesStyle = KAxis.LinesStyle()) {
        self.behavior = behavior
        self.points = points
        self.labelsStyle = labelsStyle
        self.linesStyle = linesStyle
    }
}

// MARK: - Internal
extension KAxis {
    var maxValue: CGFloat {
        points
            .map { $0.value }
            .max() ?? .zero
    }

    var minValue: CGFloat {
        points
            .map { $0.value }
            .min() ?? .zero
    }

    var hasLabels: Bool {
        points.contains { !$0.labelStyle.value.isEmptyOrNil }
    }

    var fullRange: CGFloat {
        maxValue - minValue
    }

    func xLines(for size: CGSize, yAxisHeight: CGFloat) -> [LineData] {
        points.map { point in
            let xPosition: CGFloat
            if case let .scrollable(pointsSpacing, _) = behavior.type {
                let totalWidth = pointsSpacing * (maxValue - minValue)
                xPosition = totalWidth * point.value / (maxValue - minValue) - totalWidth * minValue / (maxValue - minValue)
            } else {
                xPosition = size.width * point.value / (maxValue - minValue) - size.width * minValue / (maxValue - minValue)
            }
            return LineData(
                origin: CGPoint(x: xPosition, y: size.height - yAxisHeight),
                end: CGPoint(x: xPosition, y: size.height))
        }
    }

    func yLines(for size: CGSize, xAxisWidth: CGFloat) -> [LineData] {
        points.map { point in
            let yPosition: CGFloat
            if case let .scrollable(pointsSpacing, _) = behavior.type {
                let totalHeight = pointsSpacing * (maxValue - minValue)
                yPosition = totalHeight * point.value / (maxValue - minValue) - totalHeight * minValue / (maxValue - minValue)
            } else {
                yPosition = size.height * point.value / (maxValue - minValue) - size.height * minValue / (maxValue - minValue)
            }
            return LineData(
                origin: CGPoint(x: 0.0, y: size.height - yPosition),
                end: CGPoint(x: xAxisWidth, y: size.height - yPosition))
        }
    }

    func realAxisHeight(canvasHeight: CGFloat) -> CGFloat {
        guard case let .scrollable(pointsSpacing, _) = behavior.type else {
            return canvasHeight
        }
        return pointsSpacing * CGFloat(points.count - 1)
    }

    func realAxisWidth(canvasWidth: CGFloat) -> CGFloat {
        guard case let .scrollable(pointsSpacing, _) = behavior.type else {
            return canvasWidth
        }
        return pointsSpacing * CGFloat(points.count - 1)
    }
}
