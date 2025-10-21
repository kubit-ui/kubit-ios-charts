import SwiftUI

/// Intersect line.
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
