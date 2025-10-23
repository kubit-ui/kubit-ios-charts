public import SwiftUI

// MARK: - Configuration
public extension KLegend {
    /// Value setter for ``KLegend``. It is a numerical or percentage value that refers to the segment of the chart to which it is linked.
    /// - Parameters:
    ///   - value: new value of the legend.
    ///   - secondaryValue: secondary value for the legend. `nil` by default.
    /// - Returns: updated ``KLegend``.
    func value(_ value: String?, secondaryValue: String? = nil) -> KLegend {
        guard value != model.configuration.value || secondaryValue != model.configuration.secondaryValue else {
            return self
        }
        let legend = self
        legend.model.configuration.value = value
        legend.model.configuration.secondaryValue = secondaryValue
        return legend
    }

    /// Color setter for ``KLegend``. Figure that reflects the color applied in the chart to which it is associated.
    /// - Parameters:
    ///   - color: color for the legend color view.
    ///   - size: size of the color view. By default, width is `16.0` and height is `12.0`.
    ///   - cornerRadius: radius for the corners of the color view. `6.0` by default.
    ///   - padding: padding for the color view. `2.0` by default.
    /// - Returns: updated ``KLegend``.
    func colorView(_ color: Color?,
                   size: CGSize = CGSize(width: 16.0, height: 12.0),
                   cornerRadius: CGFloat = 6.0,
                   padding: CGFloat = 2.0) -> KLegend {
        guard color != model.configuration.colorViewColor ||
                size != model.configuration.colorViewSize ||
                cornerRadius != model.configuration.colorViewCornerRadius ||
                padding != model.configuration.colorViewPadding
        else {
            return self
        }
        let legend = self
        legend.model.configuration.colorViewColor = color
        legend.model.configuration.colorViewSize = size
        legend.model.configuration.colorViewCornerRadius = cornerRadius
        legend.model.configuration.colorViewPadding = padding
        return legend
    }

    /// Font setter for ``KLegend``. Font style to be shown on the component.
    /// - Parameters:
    ///   - font: font for the legend title.
    ///   - color: color for the font of the legend.
    /// - Returns: updated ``KLegend``.
    func titleFont(_ font: Font, color: Color = .black) -> KLegend {
        guard font != model.configuration.font || color != model.configuration.fontColor else {
            return self
        }
        let legend = self
        legend.model.configuration.font = font
        legend.model.configuration.fontColor = color
        return legend
    }

    /// Font setter for ``KLegend``. Font style to be shown on the component.
    /// - Parameters:
    ///   - font: font for the legend title.
    ///   - color: color for the font of the legend.
    /// - Returns: updated ``KLegend``.
    func valuesFont(_ font: Font, color: Color = .black) -> KLegend {
        guard font != model.configuration.valuesFont || color != model.configuration.valuesFontColor else {
            return self
        }
        let legend = self
        legend.model.configuration.valuesFont = font
        legend.model.configuration.valuesFontColor = color
        return legend
    }

    /// Vertical spacing between labels for ``KLegend``.
    /// - Parameter spacing: new spacing for ``KLegend``.
    /// - Returns: updated ``KLegend``.
    func verticalSpacing(_ spacing: CGFloat) -> KLegend {
        guard spacing != model.configuration.verticalSpacing else {
            return self
        }
        let legend = self
        legend.model.configuration.verticalSpacing = spacing
        return legend
    }
}

// MARK: - Title Alignment
public extension KLegend {
    /// Title alignment setter for ``KLegend``.
    /// - Parameter titleAlignment: title alignment for the legend.
    /// - Returns: updated ``KLegend``.
    func titleAlignment(_ titleAlignment: KLegend.TitleAlignment) -> KLegend {
        guard titleAlignment.type != model.titleAlignment.type else {
            return self
        }
        let legend = self
        legend.model.titleAlignment = titleAlignment
        return legend
    }
}

// MARK: - Orientation
public extension KLegend {
    /// Orientation setter for ``KLegend``.
    /// - Parameter orientation: orientation for the legend.
    /// - Returns: updated ``KLegend``.
    func orientation(_ orientation: KLegend.Orientation) -> KLegend {
        guard orientation.type != model.orientation.type else {
            return self
        }
        let legend = self
        legend.model.orientation = orientation
        return legend
    }
}
