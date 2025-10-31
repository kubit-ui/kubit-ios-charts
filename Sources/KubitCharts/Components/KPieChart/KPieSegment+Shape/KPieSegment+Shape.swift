import SwiftUI

/// A Shape that draws a single segment of a pie chart.
///
/// Renders either a filled pie slice or a stroked ring segment (donut) depending
/// on the `isDonut` flag. The segment is centered in the provided rect and uses
/// the smaller of rect.width and rect.height to compute the radius.
struct KPieSegment: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let isDonut: Bool
    let lineWidth: CGFloat

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        if isDonut {
            var path = Path()
            path.addArc(
                center: center,
                radius: radius - (lineWidth / 2),
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false)
            return path
        } else {
            var path = Path()
            path.move(to: center)
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false)
            path.closeSubpath()
            return path
        }
    }
}

/// Applies visual styling to a Shape:
/// - If `isDonut` is true, the shape is rendered as a stroked ring using `color` and `lineWidth`.
/// - Otherwise the shape is filled with `color`.
extension Shape {
    @ViewBuilder
    func applyStyle(isDonut: Bool, color: Color, lineWidth: CGFloat) -> some View {
        if isDonut {
            self.stroke(color, lineWidth: lineWidth)
        } else {
            self.fill(color)
        }
    }
}
