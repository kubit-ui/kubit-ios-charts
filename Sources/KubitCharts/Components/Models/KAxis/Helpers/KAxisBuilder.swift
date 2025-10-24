public import SwiftUI

/// ``KAxis`` builder.
public final class KAxisBuilder {
    private var behavior: KAxis.Behavior
    private var points: [KAxis.Point]
    private var labelsStyle: KAxis.LabelsStyle
    private var linesStyle: KAxis.LinesStyle

    /// It Initializes a new empty ``KAxisBuilder``.
    ///
    /// It creates a default axis with no points, a `.fill` behavior, and no labels or lines.
    public init() {
        behavior = .fill
        points = [KAxis.Point]()
        labelsStyle = KAxis.LabelsStyle()
        linesStyle = KAxis.LinesStyle()
    }

    /// It adds a point to the axis with a custom label and line style.
    /// - Parameters:
    ///   - value: the position of the point along the axis. Typically, `0` is the origin.
    ///   Positive values are displayed to the right and negative values to the left.
    ///   - labelStyle: instance of ``KAxis/Point/LabelStyle``. `.none` by default.
    ///   - lineStyle: instance of ``KAxis/Point/LineStyle``. `.none` by default.
    /// - Returns: the updated builder, allowing method chaining.
    public func addPoint(_ value: CGFloat,
                         labelStyle: KAxis.Point.LabelStyle = .none,
                         lineStyle: KAxis.Point.LineStyle = .none) -> Self {
        self.points.append(KAxis.Point(value, labelStyle: labelStyle, lineStyle: lineStyle))
        return self
    }

    /// It adds a point to the axis with a custom label and line style. Also adding accessibility configuration to it.
    /// - Parameters:
    ///   - value: the position of the point along the axis. Typically, `0` is the origin.
    ///   Positive values are displayed to the right and negative values to the left.
    ///   - labelStyle: instance of ``KAxis/Point/LabelStyle``. `.none` by default.
    ///   - lineStyle: instance of ``KAxis/Point/LineStyle``. `.none` by default.
    ///   - accessibility: instance of ``KAxis/Point/Accessibility``.
    /// - Returns: the updated builder, allowing method chaining.
    public func addPoint(_ value: CGFloat,
                         labelStyle: KAxis.Point.LabelStyle = .none,
                         lineStyle: KAxis.Point.LineStyle = .none,
                         accessibility: KAxis.Point.Accessibility) -> Self {
        self.points.append(KAxis.Point(value, labelStyle: labelStyle, lineStyle: lineStyle, accessibility: accessibility))
        return self
    }

    /// It adds a point to the axis with a solid line and a custom label style.
    /// - Parameters:
    ///   - value: the position of the point along the axis.
    ///   - labelStyle: instance of ``KAxis/Point/LabelStyle``. `.none` by default.
    /// - Returns: the updated builder, allowing method chaining.
    public func addPointWithDefaultSolidLine(_ value: CGFloat, labelStyle: KAxis.Point.LabelStyle = .none) -> Self {
        self.points.append(KAxis.Point(value, labelStyle: labelStyle, lineStyle: .solid()))
        return self
    }

    /// It adds a point to the axis with a dashed line and a custom label style.
    /// - Parameters:
    ///   - value: the position of the point along the axis.
    ///   - labelStyle: ``KAxis/Point/LabelStyle`` instance. `.none` by default.
    /// - Returns: the updated builder, allowing method chaining.
    public func addPointWithDefaultDashedLine(_ value: CGFloat, labelStyle: KAxis.Point.LabelStyle = .none) -> Self {
        self.points.append(KAxis.Point(value, labelStyle: labelStyle, lineStyle: .dashed()))
        return self
    }

    /// It adds a point to the axis with no line and a custom label style.
    /// - Parameters:
    ///   - value: the position of the point along the axis.
    ///   - labelStyle: ``KAxis/Point/LabelStyle`` instance. `.none` by default.
    /// - Returns: the updated builder, allowing method chaining.
    public func addPointWithClearLine(_ value: CGFloat, labelStyle: KAxis.Point.LabelStyle = .none) -> Self {
        self.points.append(KAxis.Point(value, labelStyle: labelStyle, lineStyle: .none))
        return self
    }

    /// It sets the default style for all axis labels.
    /// - Parameters:
    ///  - labelsStyle: instance of ``KAxis/LabelsStyle`` with default labels style.
    /// - Returns: the updated builder, allowing method chaining.
    public func setDefaultLabelsStyle(_ labelsStyle: KAxis.LabelsStyle) -> Self {
        self.labelsStyle = labelsStyle
        return self
    }

    /// It sets the default style for all axis lines.
    /// - Parameters:
    ///  - linesStyle: ``KAxis/LinesStyle`` instance with default lines style.
    /// - Returns: the updated builder, allowing method chaining.
    public func setDefaultLinesStyle(_ linesStyle: KAxis.LinesStyle) -> Self {
        self.linesStyle = linesStyle
        return self
    }

    /// It sets the position of the labels view along the axis.
    /// - Parameters
    ///  - position: the new position for the labels view.
    /// - Returns: the updated builder, allowing method chaining.
    public func setLabelsViewPosition(_ position: KAxis.LabelsStyle.Position) -> Self {
        self.labelsStyle.position = position
        return self
    }

    /// It sets the behavior for the axis data (for example, `.fill` or `.fit`).
    /// - Parameters:
    ///  - behavior: the behavior to apply to the axis.
    /// - Returns: the updated builder, allowing method chaining.
    public func setAxisBehavior(_ behavior: KAxis.Behavior) -> Self {
        self.behavior = behavior
        return self
    }

    /// It builds and returns a ``KAxis`` instance using the configured data.
    ///
    /// Usage example:
    /// ```swift
    /// let axis = KAxisBuilder()
    ///     .addPoint(0, labelStyle: .default())
    ///     .addPointWithDefaultSolidLine(10)
    ///     .setDefaultLabelsStyle(KAxis.LabelsStyle(font: .systemFont(ofSize: 12)))
    ///     .build()
    /// ```
    ///
    /// - Returns: a ``KAxis`` instance that represents the constructed axis.
    public func build() -> KAxis {
        KAxis(
            behavior: behavior,
            points: points,
            labelsStyle: labelsStyle,
            linesStyle: linesStyle)
    }
}
