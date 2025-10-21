public import Foundation
public import SwiftUI

public extension KImage {
    /// Size setter for ``KImage``.
    /// - Parameters:
    ///   - size: the dimensions to apply to the image. If `nil`, the view will be the original non-resizable option.
    /// - Returns: updated ``KImage``.
    func size(_ size: CGSize?) -> KImage {
        guard size != model.configuration.size else {
            return self
        }
        let image = self
        image.model.configuration.size = size
        return image
    }

    /// Tint color setter for ``KImage``.
    /// - Parameters:
    ///   - tintColor: the color used to tint the image. If `nil`, renderingMode will be original. Otherwise, it will be template.
    /// - Returns: updated ``KImage``.
    func tintColor(_ tintColor: Color?) -> KImage {
        guard tintColor != model.configuration.tintColor else {
            return self
        }
        let image = self
        image.model.configuration.tintColor = tintColor
        return image
    }

    /// Aspect ratio setter for ``KImage``.
    /// - Parameters:
    ///   - aspectRatio: the color used to tint the image. If `nil`, renderingMode will be original. Otherwise, it will be template.
    /// - Returns: updated ``KImage``.
    func aspectRatio(_ aspectRatio: KImage.AspectRatio?) -> KImage {
        guard aspectRatio != model.configuration.aspectRatio else {
            return self
        }
        let image = self
        image.model.configuration.aspectRatio = aspectRatio
        return image
    }
}
