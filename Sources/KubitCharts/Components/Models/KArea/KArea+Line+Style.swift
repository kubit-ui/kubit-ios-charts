public import SwiftUI

/// This extension provides visual style lines' area for the component.
public extension KArea.Line {
    /// Visual style of the area lines.
    struct Style: Equatable {
        let type: StyleType
        /// The width of the line.
        public let width: CGFloat
        /// The color of the line.
        public let color: Color

        enum StyleType: Equatable {
            case solid
            case dashed(pattern: [CGFloat])
        }

        /// It creates a solid visual style for a line with the specified width and color.
        /// - Parameters:
        ///   - width: the width of the line.
        ///   - color: the color of the line.
        /// - Returns: a ``Style`` instance with a solid line type.
        public static func solid(width: CGFloat, color: Color) -> Style {
            Style(type: .solid, width: width, color: color)
        }

        /// It creates a dashed visual style for a line with the specified width, color, and dash pattern.
        /// - Parameters:
        ///   - width: the width of the line.
        ///   - color: the color of the line.
        ///   - pattern: the dash pattern for the line. `[2, 2]` by default.
        /// - Returns: a ``Style`` instance with a dashed line type.
        public static func dashed(width: CGFloat, color: Color, pattern: [CGFloat] = [2, 2]) -> Style {
            Style(type: .dashed(pattern: pattern), width: width, color: color)
        }
    }
}
