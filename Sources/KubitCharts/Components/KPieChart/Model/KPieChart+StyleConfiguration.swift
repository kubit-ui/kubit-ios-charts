import SwiftUI

extension KPieChart {
    /// Visual configuration of the component.
    struct StyleConfiguration {
        /// Font style to be shown on the component.
        var font: Font
        /// Color of the font.
        var fontColor: Color?
        /// Color of the background component.
        var backgroundColor: Color?
        /// Width of the border of the component.
        var borderWidth: CGFloat
        /// Color of the inner border.
        var innerBorderColor: Color?
        /// Separator color of the component.
        var separatorColor: Color?
        /// Bool to show the full or half pie chart.
        var isHalfPieChart: Bool
        /// Padding to apply in the bottom of icon/label.
        var bottomContentPadding: CGFloat

        /// Visual configuration of the component
        ///
        /// - Parameters:
        ///   - font: font style to be shown on the component.
        ///   - fontColor: color of the font.
        ///   - backgroundColor: color of the background component. `nil` by default.
        ///   - borderWidth: width of the border of the component. `1` by default.
        ///   - innerBorderColor: color of the inner border. `nil` by default.
        ///   - separatorColor: separator color of the component. `nil` by default.
        ///   - isHalfPieChart: bool to show the complete pie chart or half pie chart.
        ///   `false` by default.
        ///   - bottomContentPadding: padding to apply at the bottom of icon/label.`0` by default.
        init(font: Font,
             fontColor: Color? = nil,
             backgroundColor: Color? = nil,
             borderWidth: CGFloat = 1,
             innerBorderColor: Color? = nil,
             separatorColor: Color? = nil,
             isHalfPieChart: Bool = false,
             bottomContentPadding: CGFloat = 0) {
            self.font = font
            self.fontColor = fontColor
            self.backgroundColor = backgroundColor
            self.borderWidth = borderWidth
            self.innerBorderColor = innerBorderColor
            self.separatorColor = separatorColor
            self.isHalfPieChart = isHalfPieChart
            self.bottomContentPadding = bottomContentPadding
        }
    }
}
