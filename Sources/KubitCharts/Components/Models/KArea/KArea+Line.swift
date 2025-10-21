public import SwiftUI

/// This extension provides line's area for the component.
public extension KArea {
    /// Line inside area.
    struct Line: Equatable {
        /// The array of points that defines the path of the line.
        public let points: [CGPoint]
        /// The appearance of the line, which defines visual properties, such as whether the lines
        /// between points are rounded or not.
        public let appearance: KLine.Appearance
        /// The style of the line, which is defined using `KArea.Line.Style`.
        public let style: KArea.Line.Style

        /// It initializes a line for a ``KArea`` with the specified parameters.
        /// - Parameters:
        ///   - points: the points that define the line.
        ///   - appearance: the appearance configuration for the line, such as color and width.
        ///   - style: the style to apply to the line.
        public init(points: [CGPoint], appearance: KLine.Appearance, style: KArea.Line.Style) {
            self.points = points
            self.appearance = appearance
            self.style = style
        }
    }
}

// MARK: - Internal
extension KArea.Line {
    var sortedXPoints: [CGPoint] {
        points.sorted { $0.x < $1.x }
    }
}
