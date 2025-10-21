import Combine

/// This extension provides a model for the component.
extension KAxisChart {
    /// Model for ``KAxisChart``.
    final class DataModel: ObservableObject {
        @Published var xAxis: KAxis
        @Published var yAxis: KAxis
        @Published var shadeRegions: [KShadeRegion]

        init(xAxis: KAxis = KAxis(), yAxis: KAxis = KAxis(), shadeRegions: [KShadeRegion] = []) {
            self.xAxis = xAxis
            self.yAxis = yAxis
            self.shadeRegions = shadeRegions
        }
    }
}
