import SwiftUI

/// An extension to create custom paths.
///
/// Usage example:
///
/// ```
/// let points = [CGPoint(x: 0, y: 1)]
/// let size = CGSize(width: 100)
/// Path.pathBuilder(points: points, linePointAppearance: .rounded, in: size)
///
/// ```
///
/// - Parameters:
///   - points: points to be shown on the chart.
///   - linePointAppearance: line point appearance to be shown on the component.
///   - size: size to calculate view dimensions.
/// - Returns: path.
extension Path {
    static func pathBuilder(points: [CGPoint], linePointAppearance: KLine.Appearance, in size: CGSize) -> Path {
        var path = Path()

        if let firstPoint = points.first {
            path.move(to: firstPoint)
        }

        for index in 1..<points.count {
            if linePointAppearance.type == .rounded {
                let currentPoint = points[index]
                let previousPoint = points[index - 1]
                let controlPoint1 = CGPoint(
                    x: (currentPoint.x + previousPoint.x) / 2,
                    y: previousPoint.y)
                let controlPoint2 = CGPoint(
                    x: (currentPoint.x + previousPoint.x) / 2,
                    y: currentPoint.y)
                path.addCurve(to: currentPoint, control1: controlPoint1, control2: controlPoint2)
            } else {
                path.addLine(to: points[index])
            }
        }

        return path
    }
}
