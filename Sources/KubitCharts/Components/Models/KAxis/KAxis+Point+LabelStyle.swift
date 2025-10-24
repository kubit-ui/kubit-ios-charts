public import SwiftUI

/// This extension provides point style for the component.
public extension KAxis.Point {
    /// Style for axis point label.
    struct LabelStyle: Equatable {
        /// The value to be displayed as label text.
        public let value: String?
        /// The font for the label text. If `nil`, the default font of the axis will be used.
        public let font: Font?
        /// The color of the label text. If `nil`, the default color of the axis will be used.
        public let color: Color?
        /// The rotation angle applied to the label text. If `nil`, no rotation will be applied.
        public let rotation: Angle?

        init(_ value: String? = nil, font: Font? = nil, color: Color? = nil, rotation: Angle? = nil) {
            self.value = value
            self.font = font
            self.color = color
            self.rotation = rotation
        }

        ///  No visible label.
        public static var none: LabelStyle {
            LabelStyle()
        }

        /// Standard horizontal label.
        /// - Parameters:
        ///   - value: string used as label text.
        ///   - font: font to display `value`. `nil` by default.
        ///   - color: text color. `nil` by default.
        /// - Returns: a ``LabelStyle`` instance configured as a horizontal label.
        public static func labeled(_ value: String, font: Font? = nil, color: Color? = nil) -> LabelStyle {
            LabelStyle(value, font: font, color: color, rotation: .zero)
        }

        /// Angled label. Useful for longer text or tight spacing.
        /// - Parameters:
        ///   - value: string used as label text.
        ///   - font: font to display `value`. `nil` by default.
        ///   - color: text color. `nil` by default.
        ///   - rotation: angle used to rotate label. `.degrees(30.0)` by default.
        /// - Returns:  a ``LabelStyle`` instance configured as a rotated label.
        public static func rotated(_ value: String,
                                   font: Font? = nil,
                                   color: Color? = nil,
                                   rotation: Angle = .degrees(30.0)) -> LabelStyle {
            LabelStyle(value, font: font, color: color, rotation: rotation)
        }
    }
}
