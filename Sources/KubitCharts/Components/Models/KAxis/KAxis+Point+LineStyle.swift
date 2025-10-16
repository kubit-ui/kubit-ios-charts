public import SwiftUI

/// This extension provides point style for the component.
public extension KAxis.Point {
    /// Configuration for axis point reference lines.
    struct LineStyle: Equatable {
        /// It indicates whether the line is visible or not.
        public let visible: Bool
        /// The width of the line. If `nil`, the default width of the axis will be used.
        public let width: CGFloat?
        /// The color of the line. If `nil`, the default color of the axis will be used.
        public let color: Color?
        /// Dash pattern for dashed lines.
        public let dashPattern: [CGFloat]

        /// No line.
        public static var none: LineStyle {
            LineStyle(visible: false, width: nil, color: nil, dashPattern: [])
        }

        /// Solid line.
        /// - Parameters:
        ///   - width: width of the line. `nil` by default. If no value is provided, ``KAxis/LinesStyle`` default width will be used.
        ///   - color: color of the line. `nil` by default. If no value is provided, ``KAxis/LinesStyle`` default color will be used.
        public static func solid(width: CGFloat? = nil, color: Color? = nil) -> LineStyle {
            LineStyle(visible: true, width: width, color: color, dashPattern: [])
        }

        /// Dashed line.
        /// - Parameters:
        ///   - width: width of the line. `nil` by default. If no value is provided, ``KAxis/LinesStyle`` default width will be used.
        ///   - color: color of the line. `nil` by default. If no value is provided, ``KAxis/LinesStyle`` default color will be used.
        ///   - dashPattern: pattern to create dash. `[4, 4]` by default.
        public static func dashed(width: CGFloat? = nil,
                                  color: Color? = nil,
                                  dashPattern: [CGFloat] = [4, 4]) -> LineStyle {
            LineStyle(visible: true, width: width, color: color, dashPattern: dashPattern)
        }
    }
}
