public import SwiftUI

public extension KPieChart {
    /// It represents a segment of the chart.
    struct Segment {
        /// Net quantity for the segment.
        var value: Double
        /// Color for the segment.
        var color: Color

        /// It initializes a new segment with the specified value and color.
        /// - Parameters:
        ///   - value: the net quantity for the segment.
        ///   - color: the color for the segment.
        public init(value: Double, color: Color) {
            self.value = value
            self.color = color
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
