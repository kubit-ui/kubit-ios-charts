import SwiftUI

public extension KPieChart.Segment {
    /// A type that represents the preset color options for pie chart segments.
    ///
    /// This type provides a predefined set of colors that maintain visual consistency
    /// across pie charts.
    /// # Preset Colors
    /// | Name       | Hex Value   |
    /// | ---------- | ----------- |
    /// | blue       | #FF324191   |
    /// | coral      | #FFCC3E42   |
    /// | cyan       | #FF0387C3   |
    /// | fuchsia    | #FFAD179E   |
    /// | green      | #FF118211   |
    /// | mint       | #FF09A182   |
    /// | orange     | #FFCC6F3F   |
    /// | pink       | #FFB11F5D   |
    /// | pistachio  | #FF858E12   |
    /// | purple     | #FF522E92   |
    /// | sand       | #FF7E705B   |
    /// | yellow     | #FF977926   |
    struct PresetColor: Sendable {
        public let rawValue: String

        private init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Orange preset color.
        public static let orange = PresetColor(rawValue: "#FFCC6F3F")

        /// Coral preset color.
        public static let coral = PresetColor(rawValue: "#FFCC3E42")

        /// Pink preset color.
        public static let pink = PresetColor(rawValue: "#FFB11F5D")

        /// Fuchsia preset color.
        public static let fuchsia = PresetColor(rawValue: "#FFAD179E")

        /// Purple preset color.
        public static let purple = PresetColor(rawValue: "#FF522E92")

        /// Blue preset color.
        public static let blue = PresetColor(rawValue: "#FF324191")

        /// Cyan preset color.
        public static let cyan = PresetColor(rawValue: "#FF0387C3")

        /// Mint preset color.
        public static let mint = PresetColor(rawValue: "#FF09A182")

        /// Green preset color.
        public static let green = PresetColor(rawValue: "#FF118211")

        /// Pistachio preset color.
        public static let pistachio = PresetColor(rawValue: "#FF858E12")

        /// Yellow preset color.
        public static let yellow = PresetColor(rawValue: "#FF977926")

        /// Sand preset color.
        public static let sand = PresetColor(rawValue: "#FF7E705B")

        var color: Color {
            Color(figmaHex: rawValue) ?? .clear
        }
    }

    /// It creates a segment with a preset color.
    /// Use this method to generate pie chart segments using predefined colors to ensure visual consistency across the chart.
    /// - Parameters:
    ///   - preset: the preset color to use for this segment.
    ///   - value: net quantity for the segment.
    /// - Returns: a new ``KPieChart.Segment`` instance with the specified preset color and value.
    static func preset(_ preset: PresetColor, value: Double) -> KPieChart.Segment {
        KPieChart.Segment(value: value, color: preset.color)
    }
}
