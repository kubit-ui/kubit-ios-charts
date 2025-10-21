public import SwiftUI

public extension KLine {
    /// Zoomable model.
    struct Zoomable: Equatable {
        let startHandle: Double
        let endHandle: Double
        let points: [CGPoint]
        let hasArea: Bool

        /// Zoomable initialization.
        /// - Parameters:
        ///   - startHandle: it refers to the interactive thumbs or draggable control on a range slider (leading).
        ///   - endHandle: it refers to the interactive thumbs or draggable control on a range slider (trailing).
        ///   - points: the set of coordinates used by the parent view to render the chart visually.
        ///   - hasArea: a boolean value that indicates whether the chart has an area representation or not.
        ///   This property is used to determine if the chart includes an area component, such as a filled region under a line chart.
        ///   `false ` by the default.
        public init(startHandle: Double, endHandle: Double, points: [CGPoint], hasArea: Bool = false) {
            self.startHandle = startHandle
            self.endHandle = endHandle
            self.points = points
            self.hasArea = hasArea
        }
    }
}

// MARK: - Internal
extension KLine {
    /// A container for the results of zooming and mapping a subset of chart points.
    /// - mapped: the points mapped to the zoomed coordinate space and canvas size.
    /// - minX, maxX: the minimum and maximum X values in the visible range.
    /// - minY, maxY: the minimum and maximum Y values in the visible range.
    struct ZoomedPoints {
        let mapped: [CGPoint]
        let minX: CGFloat
        let maxX: CGFloat
        let minY: CGFloat
        let maxY: CGFloat
    }
}
