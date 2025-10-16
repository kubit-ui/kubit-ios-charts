public import SwiftUI

// MARK: - Style
public extension KPieChart {
    /// Font setter for ``KPieChart``. Font style to be displayed on the component.
    /// - Parameters:
    ///   - font: font style to be displayed on the component.
    ///   - color: color of the font. Black by default.
    /// - Returns: updated ``KPieChart``.
    func font(_ font: Font, color: Color = .black) -> KPieChart {
        guard font != model.style.font || color != model.style.fontColor else {
            return self
        }
        let pieChart = self
        pieChart.model.style.font = font
        pieChart.model.style.fontColor = color
        return pieChart
    }

    /// Background color setter for ``KPieChart``.
    /// - Parameter color: color of the background component.
    /// - Returns: updated ``KPieChart``.
    func backgroundColor(_ color: Color?) -> KPieChart {
        guard color != model.style.backgroundColor else {
            return self
        }
        let pieChart = self
        pieChart.model.style.backgroundColor = color
        return pieChart
    }

    /// Border width setter for ``KPieChart``.
    /// - Parameter width: width of the border of the component.
    /// - Returns: updated ``KPieChart``.
    func borderWidth(_ width: CGFloat) -> KPieChart {
        guard width != model.style.borderWidth else {
            return self
        }
        let pieChart = self
        pieChart.model.style.borderWidth = width
        return pieChart
    }

    /// Inner border color setter for ``KPieChart``.
    /// - Parameter color: color of the inner border.
    /// - Returns: updated ``KPieChart``.
    func innerBorderColor(_ color: Color?) -> KPieChart {
        guard color != model.style.innerBorderColor else {
            return self
        }
        let pieChart = self
        pieChart.model.style.innerBorderColor = color
        return pieChart
    }

    /// Separator color setter for ``KPieChart``.
    /// - Parameter color: separator color of the component.
    /// - Returns: updated ``KPieChart``.
    func separatorColor(_ color: Color?) -> KPieChart {
        guard color != model.style.separatorColor else {
            return self
        }
        let pieChart = self
        pieChart.model.style.separatorColor = color
        return pieChart
    }

    /// Half pie chart setter for ``KPieChart``.
    /// - Parameter isHalfPieChart: bool to show the complete pie chart or half pie chart.
    /// - Returns: updated ``KPieChart``.
    func isHalfPieChart(_ isHalfPieChart: Bool) -> KPieChart {
        guard isHalfPieChart != model.style.isHalfPieChart else {
            return self
        }
        let pieChart = self
        pieChart.model.style.isHalfPieChart = isHalfPieChart
        return pieChart
    }

    /// Bottom content padding setter for ``KPieChart``.
    /// - Parameter bottomContentPadding: padding to apply at the bottom of icon/label.
    /// - Returns: updated ``KPieChart``.
    func bottomContentPadding(_ bottomContentPadding: CGFloat) -> KPieChart {
        guard bottomContentPadding != model.style.bottomContentPadding else {
            return self
        }
        let pieChart = self
        pieChart.model.style.bottomContentPadding = bottomContentPadding
        return pieChart
    }
}

// MARK: - Configuration
public extension KPieChart {
    /// Icon setter for  ``KPieChart``.
    /// - Parameter icon: icon to show on the component.
    /// - Returns: updated ``KPieChart``.
    func icon(_ icon: KImageResource?) -> KPieChart {
        if let currentIcon = model.configuration.icon, let newIcon = icon {
            if currentIcon.isEqual(to: newIcon) {
                return self
            }
        } else if model.configuration.icon == nil && icon == nil {
            return self
        }

        let pieChart = self
        pieChart.model.configuration.icon = icon
        return pieChart
    }

    /// Label  setter for  ``KPieChart``.
    /// - Parameter label: label to be displayed on the chart.
    /// - Returns: updated ``KPieChart``.
    func label(_ label: String?) -> KPieChart {
        guard label != model.configuration.label else {
            return self
        }
        let pieChart = self
        pieChart.model.configuration.label = label
        return pieChart
    }
}

// MARK: - Accessibility
public extension KPieChart {
    /// Accessibility label setter for  ``KPieChart``.
    /// - Parameter label: unique label for the accessibility component.
    /// - Returns: updated ``KPieChart``.
    func accessibilityLabel(_ label: String?) -> KPieChart {
        guard label != model.accessibility.label else {
            return self
        }
        let pieChart = self
        pieChart.model.accessibility.label = label
        return pieChart
    }
    
    /// Accessibility label setter for  ``KPieChart``.
    /// - Parameter value: unique value for the accessibility component.
    /// - Returns: updated ``KPieChart``.
    func accessibilityValue(_ value: String?) -> KPieChart {
        guard value != model.accessibility.value else {
            return self
        }
        let pieChart = self
        pieChart.model.accessibility.value = value
        return pieChart
    }

    /// Accessibility label setter for  ``KPieChart``.
    /// - Parameter hint: unique hint for the accessibility component.
    /// - Returns: updated ``KPieChart``.
    func accessibilityHint(_ hint: String?) -> KPieChart {
        guard hint != model.accessibility.hint else {
            return self
        }
        let pieChart = self
        pieChart.model.accessibility.hint = hint
        return pieChart
    }
}
