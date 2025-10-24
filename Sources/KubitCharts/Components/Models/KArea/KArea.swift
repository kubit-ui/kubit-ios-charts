import SwiftUI

/// #  KArea
///
/// ## How to use it:
/// ```
/// let line = KArea.Line(
///     points: exponentialPoints(factor: 5),
///     appearance: .square,
///     style: .solid(width: 1.0, color: .black))
/// let decoration = .background(.linearGradient(
///     Gradient(colors: [Color.yellow, .brown, .orange]),
///     startPoint: UnitPoint(x: 0.4, y: 0.7),
///     endPoint: UnitPoint(x: 1.0, y: 0.1)))
/// KArea(
///     mainLine: line,
///     aboveLine: line,
///     belowLine: line,
///     decoration: decoration,
///     accessibilityIdentifier: "Accessibility Identifier")
/// ```
public struct KArea: Equatable {
    /// The primary line of the area. It must have at least two points.
    public let mainLine: KArea.Line
    /// An optional line above the `mainLine`.
    public let aboveLine: KArea.Line?
    /// An optional line below the `mainLine`.
    public let belowLine: KArea.Line?
    /// The decoration for the area, which defines visual styling, such as fill colors or patterns.
    public let decoration: KArea.Decoration
    /// Accessibility information for the area, such as labels or identifiers for assistive technologies.
    let accessibility: KArea.Accessibility

    /// KArea initializer. Provided lines need to have values for minimum x and maximum x and at least 2 points.
    /// - Parameters:
    ///   - mainLine: the primary ``KArea/Line``. It must have at least two points.
    ///   - aboveLine: an optional ``KArea/Line`` above the `mainLine`. `nil` by default.
    ///   - belowLine: an optional ``KArea/Line`` below the `mainLine`. `nil` by default.
    ///   - decoration: the ``KArea.Decoration`` for the area.
    ///   - accessibilityIdentifier: the accessibility identifier of the area.
    /// - Returns: a `KArea` instance if all conditions are met, otherwise `nil`.
    ///
    /// - It fails if:
    ///   1. `mainLine` has fewer than two points.
    ///   2. both `aboveLine` and `belowLine` are `nil`, or neither contains at least two points.
    ///   3. the minimum (`x.min`) or maximum (`x.max`) values of the `x` coordinates are inconsistent across the provided lines.
    public init?(mainLine: KArea.Line,
                 aboveLine: KArea.Line? = nil,
                 belowLine: KArea.Line? = nil,
                 decoration: KArea.Decoration,
                 accessibilityIdentifier: String) {
        let aboveLinePointsCount = aboveLine?.points.count ?? 0
        let belowLinePointsCount = belowLine?.points.count ?? 0
        guard mainLine.points.count > 1, aboveLinePointsCount > 1 || belowLinePointsCount > 1 else {
            return nil
        }

        var minimumXs: [CGFloat] = [mainLine.points.map { $0.x }.min() ?? .zero]
        var maximumXs: [CGFloat] = [mainLine.points.map { $0.x }.max() ?? .zero]
        guard minimumXs.first != maximumXs.first else {
            return nil
        }

        if let aboveLine, aboveLine.points.count > 1 {
            minimumXs.append(aboveLine.points.map { $0.x }.min() ?? .zero)
            maximumXs.append(aboveLine.points.map { $0.x }.max() ?? .zero)
        }
        if let belowLine, belowLine.points.count > 1 {
            minimumXs.append(belowLine.points.map { $0.x }.min() ?? .zero)
            maximumXs.append(belowLine.points.map { $0.x }.max() ?? .zero)
        }

        let allMinimumIdentical = minimumXs.allSatisfy { $0 == minimumXs.first }
        let allMaximumIdentical = maximumXs.allSatisfy { $0 == maximumXs.first }
        guard allMinimumIdentical, allMaximumIdentical else {
            return nil
        }

        self.mainLine = mainLine
        self.aboveLine = aboveLine
        self.belowLine = belowLine
        self.decoration = decoration
        self.accessibility = Accessibility(identifier: accessibilityIdentifier)
    }
}

// MARK: - KubitChartModelContract
extension KArea: KubitChartModelContract {
    func processTap(location: CGPoint, scrollOffset: CGSize, xAxis: KAxis, yAxis: KAxis, canvasSize: CGSize) -> Bool {
        false
    }
}

// MARK: - Internal
extension KArea {
    func fullPath(xAxis: KAxis, yAxis: KAxis, canvasSize: CGSize) -> Path {
        if let aboveLine, let belowLine {
            return pathBetween(topLine: aboveLine, bottomLine: belowLine, xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize)
        } else if let aboveLine {
            return pathBetween(topLine: aboveLine, bottomLine: mainLine, xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize)
        } else if let belowLine {
            return pathBetween(topLine: mainLine, bottomLine: belowLine, xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize)
        }
        return Path()
    }

    func pathBetween(topLine: KArea.Line, bottomLine: KArea.Line, xAxis: KAxis, yAxis: KAxis, canvasSize: CGSize) -> Path {
        guard let firstBottomLinePoint = bottomLine.sortedXPoints.first,
              let lastTopLinePoint = topLine.sortedXPoints.last,
              let firstTopLinePoint = topLine.sortedXPoints.first
        else {
            return Path()
        }

        var path = Path()
        path.move(to: firstTopLinePoint.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize))
        path.addLine(to: firstBottomLinePoint.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize))

        let aboveLinePath = Path.pathBuilder(
            points: bottomLine.sortedXPoints.map { $0.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize) },
            linePointAppearance: topLine.appearance,
            in: canvasSize)
        path.addPath(aboveLinePath)
        path.addLine(to: lastTopLinePoint.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize))

        let reversedBelowLinePath = Path.pathBuilder(
            points: topLine.sortedXPoints.reversed().map { $0.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize) },
            linePointAppearance: bottomLine.appearance,
            in: canvasSize)
        path.addPath(reversedBelowLinePath)
        path.addLine(to: firstBottomLinePoint.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize))
        path.closeSubpath()
        return path
    }
}
