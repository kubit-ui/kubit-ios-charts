public import SwiftUI

/// #  KLine
///
/// It is a visual representation of data that shows an evolution of one or more variables over a period of time or a continuous sequence.
///
/// ## How to use it:
/// ```
/// let lines: [KLine] = KLine(
///     points: CGPoint(x: 1, y: 2),
///     appearance: .square,
///     style: .solid(
///         width: 2.0,
///         color: .red,
///         decoration: .background(.red),
///         accessibility: KLine.Accessibility(identifier: "KLineViewIdentifier"))
/// KAxisChart()
///     .addLines(lines)
/// ```
public struct KLine: Equatable {
    /// The array of points that defines the path of the line.
    public let points: [CGPoint]
    /// The appearance of the line, which defines visual properties such as whether the lines
    /// between points are rounded or not.
    public let appearance: KLine.Appearance
    /// The style of the line. It is defined using `KLine.Style`.
    public let style: KLine.Style
    /// It defines the optional behavior that allows the line to be zoomable.
    public let zoomable: KLine.Zoomable?
    /// Accessibility information associated with the line, such as identifiers and labels.
    let accessibility: KLine.Accessibility

    /// Line model initialization.
    /// - Parameters:
    ///   - points: points that are used to draw the line.
    ///   - appearance: appearance of the line. Lines between points may be rounded or not.
    ///   - style: style of the line.
    ///   - zoomable: it defines optional behavior that allows the line to be zoomable. `nil` by default.
    ///   - accessibilityIdentifier: accessibility identifier of the line.
    public init(points: [CGPoint],
                appearance: KLine.Appearance,
                style: KLine.Style,
                zoomable: KLine.Zoomable? = nil,
                accessibilityIdentifier: String) {
        self.points = points
        self.appearance = appearance
        self.style = style
        self.zoomable = zoomable
        self.accessibility = Accessibility(identifier: accessibilityIdentifier)
    }
}

// MARK: - KubitChartModelContract
extension KLine: KubitChartModelContract {
    func processTap(location: CGPoint, scrollOffset: CGSize, xAxis: KAxis, yAxis: KAxis, canvasSize: CGSize) -> Bool {
        false
    }
}
