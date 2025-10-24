public import SwiftUI

/// This extension provides style for the component.
public extension KLine.Style {
    /// Shadow configuration of the model.
    struct Shadow: Equatable {
        /// The color of the shadow.
        public let color: Color
        /// The radius of the shadow, which determines the blur effect.
        public let radius: CGFloat
        /// The offset of the shadow. It is represented as a CGPoint.
        public let offset: CGPoint

        /// Shadow initialization.
        /// - Parameters:
        ///   - color: color of the shadow. `Color.black` by default.
        ///   - radius: radius of the shadow. `4.0` by default.
        ///   - offset: offset of the shadow. `.zero` by default.
        public init(color: Color = .black, radius: CGFloat = 4.0, offset: CGPoint = .zero) {
            self.color = color
            self.radius = radius
            self.offset = offset
        }
    }
}
