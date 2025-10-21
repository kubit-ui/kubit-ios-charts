public import SwiftUI

/// This extension provides style for the component.
public extension KBar {
    /// Style for the segments that conform a bar.
    struct SegmentsStyle {
        /// The spacing between segments in the bar.
        public let spacing: CGFloat
        /// The default color for all the segments inside a bar if no specific color is provided for each segment.
        public let defaultColor: Color
        /// The default corner radius for all the segments inside a bar if no specific corner radius is provided for each segment.
        public let defaultCorners: KBar.Segment.Style.CornerRadius

        /// Style initializer.
        /// - Parameters:
        ///   - spacing: spacing between segments. `4.0` by default.
        ///   - defaultColor: default color for all the segments inside a bar if no color is specified for each of them. `.kubit` by default.
        ///   - defaultCorners: default corners for all the segments inside a bar if no corners are specified for each of them. `.square` by default.
        public init(spacing: CGFloat = 4.0,
                    defaultColor: Color = .kubit,
                    defaultCorners: KBar.Segment.Style.CornerRadius = .square) {
            self.spacing = spacing
            self.defaultColor = defaultColor
            self.defaultCorners = defaultCorners
        }
    }
}
