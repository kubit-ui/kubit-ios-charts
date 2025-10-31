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
        /// Width segment of the component.
        var lineWidth: CGFloat
        /// Separator color of the component.
        var separatorColor: Color?
        /// Separator width of the component.
        var separatorWidth: CGFloat
        /// Bool to show the full or half pie chart.
        var isHalfPieChart: Bool
        /// Padding to apply in the bottom of icon/label.
        var bottomContentPadding: CGFloat
        /// Bool to show donut or full width chart.
        var isDonut: Bool

        /// Visual configuration of the component.
        ///
        /// - Parameters:
        ///   - font: font style to be shown on the component.
        ///   - fontColor: color of the font. `nil` by default.
        ///   - backgroundColor: color of the background component. `nil` by default.
        ///   - lineWidth: width segment of the component. `1` by default.
        ///   - separatorColor: separator color of the component. `nil` by default.
        ///   -  separatorWidth: separator width of the component. `1` by default.
        ///   - isHalfPieChart: bool to show the complete pie chart or half pie chart. `false` by default.
        ///   - bottomContentPadding: padding to apply at the bottom of icon/label.`0` by default.
        ///   - isDonut: bool to show donut or full width chart. `false` by default.
        init(font: Font,
             fontColor: Color? = nil,
             backgroundColor: Color? = nil,
             lineWidth: CGFloat = 1,
             separatorColor: Color? = nil,
             separatorWidth: CGFloat = 1,
             isHalfPieChart: Bool = false,
             bottomContentPadding: CGFloat = 0,
             isDonut: Bool = false) {
            self.font = font
            self.fontColor = fontColor
            self.backgroundColor = backgroundColor
            self.lineWidth = lineWidth
            self.separatorColor = separatorColor
            self.separatorWidth = separatorWidth
            self.isHalfPieChart = isHalfPieChart
            self.bottomContentPadding = bottomContentPadding
            self.isDonut = isDonut
        }
    }
}
