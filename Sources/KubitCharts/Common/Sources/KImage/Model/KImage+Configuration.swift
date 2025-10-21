public import SwiftUI

extension KImage {
    /// Visual configuration of the component.
    struct Configuration {
        /// Resource to be shown on the component.
        var resource: KImageResource
        /// The color used to tint the image.
        var tintColor: Color?
        /// The size used to resize the image.
        var size: CGSize?
        /// Aspect ratio configuration.
        var aspectRatio: AspectRatio?
        /// Resizing configuration for GSImage.
        var resizingConfiguration: ResizingConfiguration
    }

    /// Aspect ratio configuration.
    public struct AspectRatio: Equatable {
        /// It controls the aspect ratio of the image.
        public var ratio: CGFloat?
        /// ContentMode that will be applied to the inner image.
        public var contentMode: ContentMode

        /// Aspect ratio configuration.
        ///
        /// - Parameters:
        ///  - ratio: it controls the aspect ratio of the image. If `nil` is provided, the aspect ratio will be kept.
        ///  - contentMode: the content mode that will be applied to the inner image.
        public init(_ ratio: CGFloat? = nil, contentMode: ContentMode) {
            self.ratio = ratio
            self.contentMode = contentMode
        }
    }

    /// Resizing configuration of the component.
    public struct ResizingConfiguration {
        let type: ResizingConfigurationType

        enum ResizingConfigurationType {
            case none
            case stretch
            case tile
        }

        /// `None`: no resizable image. 
        public static var none: ResizingConfiguration {
            ResizingConfiguration(type: .none)
        }

        /// `Stretch`: resizable image.
        public static var stretch: ResizingConfiguration {
            ResizingConfiguration(type: .stretch)
        }

        /// `Tile`: resizable image.
        public static var tile: ResizingConfiguration {
            ResizingConfiguration(type: .tile)
        }

        var imageResizingMode: Image.ResizingMode? {
            switch self.type {
            case .stretch:
                Image.ResizingMode.stretch
            case .tile:
                Image.ResizingMode.tile
            case .none:
                nil
            }
        }
    }
}
