public import SwiftUI

/// This extension provides point setup for the component.
public extension KAxis {
    /// Struct that represents a point of interest inside an axis.
    struct Point: Equatable {
        /// The position of the point along the axis. It is represented as a `CGFloat`.
        public let value: CGFloat
        /// The label style for the axis point, which determines how the label is displayed.
        public let labelStyle: KAxis.Point.LabelStyle
        /// The line style for the axis point, which determines how the line associated with the point is displayed.
        public let lineStyle: KAxis.Point.LineStyle

        /// Axis Point Style initializer.
        /// - Parameters:
        ///   - value: the position of the point along the axis.
        ///   - labelStyle: label style for the point. `.none` by default.
        ///   - lineStyle: line style for the point. `.none` by default.
        public init(_ value: CGFloat, labelStyle: KAxis.Point.LabelStyle = .none, lineStyle: KAxis.Point.LineStyle = .none) {
            self.value = value
            self.labelStyle = labelStyle
            self.lineStyle = lineStyle
        }
    }
}
