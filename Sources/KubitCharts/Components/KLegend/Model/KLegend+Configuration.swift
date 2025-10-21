import SwiftUI

/// This extension provides configuration for the component.
extension KLegend {
    struct Configuration {
        var title: String
        var value: String?
        var secondaryValue: String?
        var font: Font = .system(size: 12, weight: .regular)
        var fontColor: Color = .black
        var valuesFont: Font = .system(size: 16, weight: .bold)
        var valuesFontColor: Color = .black
        var verticalSpacing: CGFloat = 2.0
        var colorViewColor: Color?
        var colorViewSize = CGSize(width: 16.0, height: 12.0)
        var colorViewCornerRadius: CGFloat = 6.0
        var colorViewPadding: CGFloat = 2.0
    }
}
