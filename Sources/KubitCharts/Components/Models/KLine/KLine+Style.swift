public import SwiftUI

/// This extension provides style for the component.
public extension KLine {
    /// Visual style of the line.
    struct Style: Equatable {
        let type: StyleType
        /// The width of the line.
        public let width: CGFloat
        /// The color of the line.
        public let color: Color
        /// Additional decoration applied to the line (for example, shadow or background).
        public let decoration: KLine.Style.Decoration

        enum StyleType: Equatable {
            case solid
            case dashed(pattern: [CGFloat])
        }

        /// Solid visual style.
        /// - Parameters:
        ///   - width: line width.
        ///   - color: line color.
        ///   - decoration: decoration for line. `.none` by default.
        public static func solid(width: CGFloat, color: Color, decoration: KLine.Style.Decoration = .none) -> Style {
            Style(type: .solid, width: width, color: color, decoration: decoration)
        }

        /// Dashed visual style.
        /// - Parameters:
        ///   - width: line width.
        ///   - color: line color.
        ///   - pattern: dash pattern for the line. `[2, 2]` by default.
        ///   - decoration: line decoration. `.none` by default.
        public static func dashed(width: CGFloat,
                                  color: Color,
                                  pattern: [CGFloat] = [2, 2],
                                  decoration: KLine.Style.Decoration = .none) -> Style {
            Style(type: .dashed(pattern: pattern), width: width, color: color, decoration: decoration)
        }
    }
}
