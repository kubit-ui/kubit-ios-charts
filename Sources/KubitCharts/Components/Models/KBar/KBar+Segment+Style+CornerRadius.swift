public import SwiftUI

/// This extension provides style for the component.
public extension KBar.Segment.Style {
    /// Corner radius information for the bar (or segments).
    struct CornerRadius: Equatable {
        /// Corner radius for the top leading corner.
        public let topLeading: CGFloat
        /// Corner radius for the bottom leading corner.
        public let bottomLeading: CGFloat
        /// Corner radius for the top trailing corner.
        public let topTrailing: CGFloat
        /// Corner radius for the bottom trailing corner.
        public let bottomTrailing: CGFloat

        /// KBar.Segment.Style.CornerRadius initializer.
        /// - Parameters:
        ///   - topLeading: corner radius for the top leading corner. `4.0` by default.
        ///   - bottomLeading: corner radius for the bottom leading corner. `4.0` by default.
        ///   - topTrailing: corner radius for the top trailing corner. `4.0` by default.
        ///   - bottomTrailing: corner radius for the bottom trailing corner. `4.0` by default.
        public init(topLeading: CGFloat = 4.0,
                    bottomLeading: CGFloat = 4.0,
                    topTrailing: CGFloat = 4.0,
                    bottomTrailing: CGFloat = 4.0) {
            self.topLeading = topLeading
            self.bottomLeading = bottomLeading
            self.topTrailing = topTrailing
            self.bottomTrailing = bottomTrailing
        }

        /// No rounded corners.
        public static var square: CornerRadius {
            CornerRadius(topLeading: .zero, bottomLeading: .zero, topTrailing: .zero, bottomTrailing: .zero)
        }

        /// Rounded corners.
        /// - Parameter radius: radius for the corners. `4.0` by default.
        public static func rounded(_ radius: CGFloat = 4.0) -> CornerRadius {
            CornerRadius(topLeading: radius, bottomLeading: radius, topTrailing: radius, bottomTrailing: radius)
        }

        /// Only leading corners are rounded.
        /// - Parameter radius: radius for the leading corners. `4.0` by default.
        public static func leadingRoundedOnly(_ radius: CGFloat = 4.0) -> CornerRadius {
            CornerRadius(topLeading: radius, bottomLeading: radius, topTrailing: .zero, bottomTrailing: .zero)
        }

        /// Only trailing corners rounded.
        /// - Parameter radius: radius for the trailing corners. `4.0` by default.
        public static func trailingRoundedOnly(_ radius: CGFloat = 4.0) -> CornerRadius {
            CornerRadius(topLeading: .zero, bottomLeading: .zero, topTrailing: radius, bottomTrailing: radius)
        }

        /// Only top corners are rounded.
        /// - Parameter radius: radius for the top corners.  `4.0` by default.
        public static func topRoundedOnly(_ radius: CGFloat = 4.0) -> CornerRadius {
            CornerRadius(topLeading: radius, bottomLeading: .zero, topTrailing: radius, bottomTrailing: .zero)
        }

        /// Only bottom corners are rounded.
        /// - Parameter radius: radius for the bottom corners.  `4.0` by default.
        public static func bottomRoundedOnly(_ radius: CGFloat = 4.0) -> CornerRadius {
            CornerRadius(topLeading: .zero, bottomLeading: radius, topTrailing: .zero, bottomTrailing: radius)
        }
    }
}
