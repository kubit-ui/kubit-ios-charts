public import SwiftUI

/// #  KLegend View
/// 
/// A component that displays legends with primary and secondary values, with extensive customization
/// options for colors, alignment, and orientation.
///
/// ## How to use it:
/// ```
///  KLegend(title: "Title", identifier: "KLegend.America.Identifier")
///      .value("30%", secondaryValue: "5%")
///      .colorView(.black)
///      .titleFont(...)
///      .titleAlignment(.end)
///      .orientation(.vertical)
/// ```
///
/// This component also supports accessibility.
public struct KLegend: View {
    @ObservedObject var model: Model

    /// It initializes the legend view with title and accessibility identifier. Title alignment and orientation are `.start` and `.horizontal`.
    /// - Parameters:
    ///   - title: title of the legend view.
    ///   - accessibilityIdentifier: accessibility identifier for the component.
    public init(title: String, accessibilityIdentifier: String) {
        self.model = Model(configuration: Configuration(title: title),
                           accessibility: Accessibility(identifier: accessibilityIdentifier))
    }

    public var body: some View {
        switch model.orientation.type {
        case let .horizontal(spacing):
            horizontalView(spacing: spacing)
        case .vertical:
            verticalView
        }
    }
}

// MARK: - Inner Views
private extension KLegend {
    var verticalView: some View {
        VStack(alignment: containerAlignment, spacing: configuration.verticalSpacing) {
            colorTitleContainer
            value
            secondValue
        }
        .accessibility(identifier: accessibility.identifier)
    }

    func horizontalView(spacing: CGFloat) -> some View {
        HStack(alignment: .top, spacing: spacing) {
            if titleAlignment.type == .start {
                colorTitleContainer
            }
            VStack(spacing: configuration.verticalSpacing) {
                value
                secondValue
            }
            if titleAlignment.type == .end {
                colorTitleContainer
            }
        }
        .accessibility(identifier: accessibility.identifier)
    }

    var colorTitleContainer: some View {
        HStack(alignment: .center, spacing: 8) {
            colorContainer
            title
        }
    }

    var title: some View {
        Text(configuration.title)
            .font(configuration.font)
            .multilineTextAlignment(textAlignment)
            .foregroundColor(configuration.fontColor)
    }

    @ViewBuilder var value: some View {
        if let value = configuration.value {
            Text(value)
                .font(configuration.valuesFont)
                .multilineTextAlignment(textAlignment)
                .foregroundColor(configuration.valuesFontColor)
        }
    }

    @ViewBuilder var secondValue: some View {
        if let secondValue = configuration.secondaryValue {
            Text(secondValue)
                .font(configuration.valuesFont)
                .multilineTextAlignment(textAlignment)
                .foregroundColor(configuration.valuesFontColor)
        }
    }

    @ViewBuilder var colorContainer: some View {
        if let color = configuration.colorViewColor {
            Rectangle()
                .frame(width: configuration.colorViewSize.width, height: configuration.colorViewSize.height)
                .foregroundColor(color)
                .cornerRadius(configuration.colorViewCornerRadius)
                .padding(configuration.colorViewPadding)
        }
    }
}

// MARK: - Shortcuts
private extension KLegend {
    var titleAlignment: KLegend.TitleAlignment {
        model.titleAlignment
    }

    var orientation: KLegend.Orientation {
        model.orientation
    }

    var accessibility: KLegend.Accessibility {
        model.accessibility
    }

    var configuration: KLegend.Configuration {
        model.configuration
    }

    var textAlignment: TextAlignment {
        switch titleAlignment.type {
        case .start:
            TextAlignment.leading
        case .end:
            TextAlignment.trailing
        }
    }

    var containerAlignment: HorizontalAlignment {
        switch titleAlignment.type {
        case .start:
            HorizontalAlignment.leading
        case .end:
            HorizontalAlignment.trailing
        }
    }
}
