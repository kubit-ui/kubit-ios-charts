public import SwiftUI

/// # KImage
///
/// This component is used to show images. Images can be LocalResources such as assets, or RemoteResources such as http images.
/// For RemoteResources you can also use GSAsyncImage.
///
/// ## How to use it:
/// ```
/// // Local
/// KImage(resource: myIcon)
///    .tintColor(.black)
///    .size(CGSize(width: 24, height: 24))
/// ```
public struct KImage: View {
    @ObservedObject var model: Model

    /// It initializes ``KImage``
    /// - Parameters:
    ///   - resource: resource to be shown on the component.
    ///   - resizing: resizing configuration of the image. `none` is the default value.
    public init(resource: KImageResource, resizing: ResizingConfiguration = .none) {
        self.model = Model(configuration: Configuration(resource: resource, resizingConfiguration: resizing))
    }

    public var body: some View {
        switch configuration.resource.type {
        case .data, .local:
            dataImage
        case .unknown:
            EmptyView()
        }
    }
}

// MARK: - Inner Views
private extension KImage {
    var dataImage: some View {
        let resizingMode = configuration.resizingConfiguration.imageResizingMode ?? .stretch
        let contentMode: ContentMode = resizingMode == .stretch ? .fit : .fill
        return Image(configuration)?
            .aspectRatio(
                configuration.aspectRatio?.ratio,
                contentMode: configuration.aspectRatio?.contentMode ?? contentMode)
            .foregroundColor(configuration.tintColor)
            .frame(width: configuration.size?.width, height: configuration.size?.height)
            .clipped()
            .accessibilityHidden(true)
    }
}

// MARK: - Image extension
@MainActor
private extension Image {
    init?(_ configuration: KImage.Configuration) {
        if let dataResource = configuration.resource as? KImage.DataResource,
           let image = UIImage(data: dataResource.data) {
            self.init(uiImage: image)
        } else if let resource = configuration.resource as? KImage.LocalResource {
            self.init(resource.name, bundle: resource.bundle)
        } else {
            return nil
        }
        apply(configuration)
    }

    mutating func apply(_ configuration: KImage.Configuration) {
        let isResizable = configuration.resizingConfiguration.type != .none
        if isResizable || configuration.size != nil || configuration.aspectRatio?.ratio != nil {
            self = self.resizable(resizingMode: configuration.resizingConfiguration.imageResizingMode ?? .stretch)
        }

        self = self.renderingMode(configuration.tintColor != nil ? .template : .original)
    }
}

// MARK: - Shortcuts
private extension KImage {
    var configuration: Configuration {
        model.configuration
    }
}
