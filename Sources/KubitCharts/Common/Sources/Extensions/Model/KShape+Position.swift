public import SwiftUI

/// This extension provides position utilities for KShape.
public extension KShape {
    /// Unmapped position of the shape. Origin and radius need to be expressed in the same magnitudes of the axes.
    struct Position: Equatable {
        var center: CGPoint
        var xRadius: CGFloat
        var rotation: Angle
        var haloWidth: CGFloat

        /// Position initializer.
        /// - Parameters:
        ///   - center: center of the shape expressed in the same magnitudes as X-axis and Y-axis.
        ///   - xRadius: radius of the shape expressed in the same magnitud of X-axis.
        ///   - rotation: rotation of the shape. Angle. `.zero` by default.
        ///   - haloWidth: width of the halo. `.zero` by default.
        public init(center: CGPoint, xRadius: CGFloat, rotation: Angle = .zero, haloWidth: CGFloat = .zero) {
            self.center = center
            self.xRadius = xRadius
            self.rotation = rotation
            self.haloWidth = haloWidth
        }
    }
}
