public import SwiftUI

/// This extension provides a helper for the component.
public extension KAxis {
    /// ``KAxis/Point`` builder.
    final class PointBuilder {
        private var value: CGFloat
        private var labelStyle: KAxis.Point.LabelStyle
        private var lineStyle: KAxis.Point.LineStyle

        /// ``KAxis/PointBuilder`` initializer. It creates a point with `value`.
        /// Label and line styles are `.none`.
        /// - Parameter value: value of the point.
        public init(_ value: CGFloat) {
            self.value = value
            self.labelStyle = .none
            self.lineStyle = .none
        }

        /// It sets a label style for the inner ``KAxis/Point``.
        /// - Parameter labelStyle: new label style.
        /// - Returns: the updated builder, allowing the change of method.
        public func setLabelStyle(_ labelStyle: KAxis.Point.LabelStyle) -> Self {
            self.labelStyle = labelStyle
            return self
        }

        ///  It sets line style for the inner ``KAxis/Point``.
        /// - Parameter lineStyle: new line style.
        /// - Returns: the updated builder, allowing method chaining.
        public func setLineStyle(_ lineStyle: KAxis.Point.LineStyle) -> Self {
            self.lineStyle = lineStyle
            return self
        }

        /// It builds a new ``KAxis/Point`` instance using the properties specified in the builder.
        ///
        /// This method finalizes the configuration of the point by combining its value, label style, and line style
        /// into a single immutable instance of ``KAxis/Point``. The resulting point can then be used in a chart axis
        /// to represent a specific coordinate or labeled marker.
        ///
        /// Usage example:
        /// ```swift
        /// let point = KAxis.PointBuilder(10.0)
        ///     .setLabelStyle(.labeled("Example"))
        ///     .setLineStyle(.solid(width: 1.0, color: .blue))
        ///     .build()
        /// ```
        ///
        /// - Returns: a ``KAxis/Point`` instance with the configured value, label style, and line style
        ///   specified in the builder.
        public func build() -> KAxis.Point {
            KAxis.Point(value, labelStyle: labelStyle, lineStyle: lineStyle)
        }
    }
}
