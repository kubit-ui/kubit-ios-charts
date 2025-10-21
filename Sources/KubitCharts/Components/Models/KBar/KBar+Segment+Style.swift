// swiftlint:disable:this file_name
public import SwiftUI

/// This extension provides style for the component.
public extension KBar.Segment {
    /// Style of the segment.
    struct Style: Equatable {
        /// The color of the segment. If `nil`, the default color of the segment will be used.
        public let color: Color?
        /// Corner radius configuration of the segment.
        public let corners: KBar.Segment.Style.CornerRadius

        /// Style initializer.
        /// - Parameters:
        ///   - color: color of the segment. `nil` by default. If no color is specified, defaultColor from ``KBar/SegmentsStyle`` will be used instead.
        ///   - corners: corners for the segment. `.square` by default.
        public init(color: Color? = nil, corners: KBar.Segment.Style.CornerRadius = .square) {
            self.color = color
            self.corners = corners
        }
    }
}
