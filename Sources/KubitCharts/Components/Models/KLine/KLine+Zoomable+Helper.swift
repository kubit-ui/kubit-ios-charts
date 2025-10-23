import SwiftUI

// MARK: - Helper
extension KLineView {
    /// It maps and zooms a subset of chart points based on the provided handles and canvas size.
    /// - Parameters:
    ///   - startHandle: the normalized start position (0.0 to 1.0) for the visible range.
    ///   - endHandle: the normalized end position (0.0 to 1.0) for the visible range.
    ///   - points: the full array of chart points.
    ///   - canvasSize: the size of the drawing canvas.
    ///   - appearance: the appearance configuration for the line points.
    /// - Returns: a tuple that contains:
    ///   - mapped: the visible points mapped to the zoomed coordinate space and canvas size.
    ///   - minX, maxX: the minimum and maximum X values in the visible range.
    ///   - minY, maxY: the minimum and maximum Y values in the visible range.
    func mapperZoomedPoints(startHandle: Double,
                            endHandle: Double,
                            points: [CGPoint],
                            canvasSize: CGSize) -> KLine.ZoomedPoints {
        let startIndex = Int(Double(points.count) * startHandle)
        let endIndex = Int(Double(points.count) * endHandle)
        let visiblePoints = Array(points[startIndex..<endIndex])

        let minX = visiblePoints.map(\.x).min() ?? 0
        let maxX = visiblePoints.map(\.x).max() ?? 1
        let minY = visiblePoints.map(\.y).min() ?? 0
        let maxY = visiblePoints.map(\.y).max() ?? 1

        let mapped = visiblePoints.map {
            $0.zoomed(minX: minX, maxX: maxX, minY: minY, maxY: maxY, canvasSize: canvasSize)
        }
        return KLine.ZoomedPoints(mapped: mapped, minX: minX, maxX: maxX, minY: minY, maxY: maxY)
    }
}
