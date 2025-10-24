import SwiftUI

/// #  KIntersectLine
///
/// A line that extends from a node to help highlight or indicate its position more clearly.
///
/// ## How to use it:
/// ```
/// let xAxis = SBAxisHelper.defaultAxis(position: .end, label0: "V0", label: "VX")
/// let yAxis = SBAxisHelper.defaultAxis(position: .start, label0: "V0", label: "VY")
/// KAxisChart()
///     .xAxis(xAxis)
///     .yAxis(yAxis)
///     .addNodes([
///         .polygon(
///             position: KShape.Position(center: CGPoint(x: 2.0, y: 2.0), xRadius: 0.2),
///             numberOfVertices: 4,
///             style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
///             accessibility: .decorative(identifier: "Square1")),
///         .polygon(
///             position: KShape.Position(center: CGPoint(x: 1.0, y: 2.0), xRadius: 0.2),
///             numberOfVertices: 4,
///             style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
///             accessibility: .decorative(identifier: "Square2"))
///     ])
///     .setHorizontalIntersectLine(color: Color.green)
/// ```
struct KIntersectLine: Equatable {
    let color: Color
    let width: CGFloat
    let dashPattern: [CGFloat]
    let orientation: KIntersectLine.Orientation

    enum Orientation {
        case horizontal
        case vertical
    }
}

// MARK: - KubitChartModelContract
extension KIntersectLine: KubitChartModelContract {
    func processTap(location: CGPoint, scrollOffset: CGSize, xAxis: KAxis, yAxis: KAxis, canvasSize: CGSize) -> Bool {
        false
    }
}
