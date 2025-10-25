public import SwiftUI

public extension KPieChart {
    /// It represents a segment of the chart.
    struct Segment {
        /// Net quantity for the segment.
        var value: Double
        /// Color for the segment.
        var color: Color
        /// Accessibility for the segment.
        var accessibility: Accessibility

        /// It initializes a new segment with the specified value and color.
        /// - Parameters:
        ///   - value: the net quantity for the segment.
        ///   - color: the color for the segment.
        public init(value: Double, color: Color) {
            self.value = value
            self.color = color
            self.accessibility = Accessibility()
        }

        /// It creates a segment with a custom color.
        /// - Parameters:
        ///   - value: the net quantity for the segment.
        ///   - color: the custom color for the segment.
        /// - Returns: a segment with the specified value and custom color.
        public static func custom(value: Double, color: Color) -> Segment {
            Segment(value: value, color: color)
        }

        /// It creates a segment with a custom color from a hexadecimal string.
        /// - Parameters:
        ///   - value: the net quantity for the segment.
        ///   - hexadecimalColor: raw hexadecimal color string (excluding alpha and hash). For example: `"CC6F3F"`.
        ///     - The string should be 6 characters (RRGGBB) long.
        ///     - **Do not include `#` at the start.**
        /// - Returns: a segment with the specified value and custom color.
        public static func custom(value: Double, hexadecimalColor: String) -> Segment {
            let color = Color(figmaHex: "FF" + hexadecimalColor) ?? .clear
            return Segment(value: value, color: color)
        }
    }
}

public extension KPieChart.Segment {
    /// Accessibility information needed to make the component accessible and testable.
    struct Accessibility {
        /// It is used as `accessibilityIdentifier` for the component.
        var identifier: String?
        /// It is used as `accessibilityLabel` for the component.
        var label: String?
        /// It is used as `accessibilityValue` for the component.
        var value: String?
        /// It is used as `accessibilityHint` for the component.
        var hint: String?

        /// It is used to know if the accessibility has been configured for this component.
        public var isAccessible: Bool {
            label != nil || value != nil || hint != nil
        }
    }
}

// MARK: - Accessibility
public extension KPieChart.Segment {
    /// Accessibility label setter for  ``KPieChart.Segment``.
    /// - Parameter identifier: unique accessibility identifier for the component.
    /// - Returns: updated ``KPieChart.Segment``.
    func accessibilityIdentifier(_ identifier: String?) -> KPieChart.Segment {
        guard identifier != accessibility.identifier else {
            return self
        }
        var segment = self
        segment.accessibility.identifier = identifier
        return segment
    }

    /// Accessibility label setter for  ``KPieChart.Segment``.
    /// - Parameter label: accessibility label for the component.
    /// - Returns: updated ``KPieChart.Segment``.
    func accessibilityLabel(_ label: String?) -> KPieChart.Segment {
        guard label != accessibility.label else {
            return self
        }
        var segment = self
        segment.accessibility.label = label
        return segment
    }

    /// Accessibility label setter for  ``KPieChart.Segment``.
    /// - Parameter value: accessibility value for the component.
    /// - Returns: updated ``KPieChart.Segment``.
    func accessibilityValue(_ value: String?) -> KPieChart.Segment {
        guard value != accessibility.value else {
            return self
        }
        var segment = self
        segment.accessibility.value = value
        return segment
    }

    /// Accessibility label setter for  ``KPieChart.Segment``.
    /// - Parameter hint: accessibility hint for the component.
    /// - Returns: updated ``KPieChart.Segment``.
    func accessibilityHint(_ hint: String?) -> KPieChart.Segment {
        guard hint != accessibility.hint else {
            return self
        }
        var segment = self
        segment.accessibility.hint = hint
        return segment
    }
}
