import Foundation

/// Custom background model.
public struct KCustomBackground: Equatable {
    /// The source of the background, which defines where the background content is derived from.
    public let source: Source
    /// Accessibility information associated with the custom background, such as identifiers and labels.
    let accessibility: KCustomBackground.Accessibility

    /// Custom background model initialization.
    /// - Parameters:
    ///   - source: source of the background.
    ///   - accessibilityIdentifier: accessibility identifier of the background.
    public init(source: Source, accessibilityIdentifier: String) {
        self.source = source
        self.accessibility = Accessibility(identifier: accessibilityIdentifier)
    }
}

// MARK: - KubitChartModelContract
extension KCustomBackground: KubitChartModelContract {
    func processTap(location: CGPoint, scrollOffset: CGSize, xAxis: KAxis, yAxis: KAxis, canvasSize: CGSize) -> Bool {
        false
    }
}
