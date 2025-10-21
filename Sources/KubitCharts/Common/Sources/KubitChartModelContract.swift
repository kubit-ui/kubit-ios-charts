import Foundation

protocol KubitChartModelContract {
    func processTap(location: CGPoint,
                    scrollOffset: CGSize,
                    xAxis: KAxis,
                    yAxis: KAxis,
                    canvasSize: CGSize) -> Bool
}
