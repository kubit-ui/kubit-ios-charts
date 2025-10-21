public import SwiftUI

/// This extension provides style utilities for KShape.
public extension KShape {
    /// Style for the shape.
    struct Style: Equatable {
        /// The color used to fill the shape.
        public let fillColor: Color
        /// The color used to stroke the shape.
        public let borderColor: Color
        /// The width of the shape's border.
        public let borderWidth: CGFloat
        /// The color of the halo.
        public let haloColor: Color?

        /// Style initializer.
        /// - Parameters:
        ///   - fillColor: color used to fill the shape.
        ///   - borderColor: color used to stroke the shape.
        ///   - borderWidth: border width of the shape.
        ///   - haloColor: color of the halo.
        public init(fillColor: Color, borderColor: Color, borderWidth: CGFloat, haloColor: Color? = nil) {
            self.fillColor = fillColor
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.haloColor = haloColor
        }
    }
}
