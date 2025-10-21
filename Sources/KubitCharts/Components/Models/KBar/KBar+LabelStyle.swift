public import SwiftUI

/// This extension provides style for the component.
public extension KBar {
    /// Label style for bars.
    struct LabelStyle: Equatable {
        /// Optional text value for the label.
        public let value: String?
        /// The font to render the text of the label.
        public let font: Font
        /// The color to draw the text of the label.
        public let color: Color
        /// The position of the label in relation to the bar.
        public let position: KBar.LabelStyle.Position
        /// The spacing between the bar and the label.
        public let barSpacing: CGFloat
        /// The spacing between lines of the label text (only applicable for vertical orientation).
        public let lineSpacing: CGFloat

        // Internal init.
        init(_ value: String? = nil,
             font: Font = .system(size: 12.0),
             color: Color = .gray,
             position: KBar.LabelStyle.Position = .topLeading,
             barSpacing: CGFloat = 4.0,
             lineSpacing: CGFloat = 14.0) {
            self.value = value
            self.font = font
            self.color = color
            self.position = position
            self.barSpacing = barSpacing
            self.lineSpacing = lineSpacing
        }

        /// A configuration where no label is displayed.
        public static var none: LabelStyle {
            LabelStyle()
        }

        /// Labeled.
        /// - Parameters:
        ///   - value: text displayed inside the label.
        ///   - font: font to draw the text. `.system(size: 12.0)` by default.
        ///   - color: color to draw the text. `.gray` by default.
        ///   - position: position of the label.  `.topLeading` by default.
        ///   - barSpacing: spacing between the bar and the label. `4.0` by default.
        ///   - lineSpacing: space between lines of the label (only for vertical orientation). `14.0` by default.
        public static func labeled(_ value: String,
                                   font: Font = .system(size: 12.0),
                                   color: Color = .gray,
                                   position: Position = .topLeading,
                                   barSpacing: CGFloat = 4.0,
                                   lineSpacing: CGFloat = 14.0) -> LabelStyle {
            LabelStyle(value, font: font, color: color, position: position, barSpacing: barSpacing, lineSpacing: lineSpacing)
        }
    }
}
