public import Foundation

/// #  KBar
///
/// Is a visual representation of categorical data by means of rectangular bars. The length or height of each bar is proportional to the value it represents. It can contain horizontal or vertical bars to compare the values of different categories. Used to compare multiple part-to-whole relationships or ranking a single data set.
///
/// ## How to use it:
/// ```
/// let verticalBar = KBar.vertical(
///     origin: 1,
///     width: 0.5,
///     segments: [
///         KBar.Segment(
///             identifier: UUID().uuidString,
///             value: 1.0,
///             style: KBar.Segment.Style(color: .black, corners: .square),
///             accessibilityLabel: "Acc label for bar 1 segment 1",
///             accessibilityValue: "1 point")
///     ],
///     yOffset: .zero,
///     segmentsStyle: KBar.SegmentsStyle(),
///     labelStyle: KBar.LabelStyle("Bar 1", color: .black, position: .bottom),
///     accessibilityIdentifier: "Bar Identifier",
///     accessibilityLabel: "Bar label")
/// ```
public struct KBar: Equatable {
    /// The origin point of the bar. It is represented as a CGPoint.
    public let origin: CGPoint
    /// The width of the bar.
    public let width: CGFloat
    /// The orientation of the bar, which can be horizontal or vertical.
    public let orientation: KBar.Orientation
    /// The segments data of the bar. Each segment represents a portion of the bar.
    /// At least one segment must be provided.
    public let segments: [KBar.Segment]
    /// The style of the bar's segments, which allows customization of appearance like spacing and default styling.
    public let segmentsStyle: KBar.SegmentsStyle
    /// The label style of the bar, which determines the appearance and behavior of the label.
    public let labelStyle: KBar.LabelStyle
    /// Accessibility information associated with the bar, such as identifiers and labels.
    let accessibility: KBar.Accessibility

    /// Horizontal KBar initializer.
    /// - Parameters:
    ///   - origin: origin of the bar expressed in the magnitude of Y-axis. This parameter needs to match the point where
    ///   the center of the bar is located in the Y-axis.
    ///   - height: height of the bar expressed in the same magnitude as Y-axis.
    ///   - segments: inner segments data. At least one segment needs to be provided.
    ///   - xOffset: it allows to change the origin the bar in the X-axis. This value needs to be expressed in the magnitude of Y-axis.
    ///   `.zero` by default (the bar starts in x = 0).
    ///   - segmentsStyle: ``KBar/SegmentsStyle`` instance to customize view appearance.
    ///   Initialized with default parameters by default.
    ///   - labelStyle: ``KBar/LabelStyle`` instance to customize label appearance. It is initialized to `.none` by default (no label).
    ///   - accessibilityIdentifier: accessibility identifier for the bar. It is propagated to inner components.
    ///   - accessibilityLabel: accessibility label for the bar.
    public static func horizontal(origin: CGFloat,
                                  height: CGFloat,
                                  segments: [KBar.Segment],
                                  xOffset: CGFloat = .zero,
                                  segmentsStyle: KBar.SegmentsStyle = KBar.SegmentsStyle(),
                                  labelStyle: KBar.LabelStyle = .none,
                                  accessibilityIdentifier: String,
                                  accessibilityLabel: String) -> KBar {
        KBar(
            origin: CGPoint(x: xOffset, y: origin),
            width: height,
            orientation: .horizontal,
            segments: segments,
            segmentsStyle: segmentsStyle,
            labelStyle: labelStyle,
            accessibility: Accessibility(identifier: accessibilityIdentifier, label: accessibilityLabel))
    }

    /// Vertical KBar initializer.
    /// - Parameters:
    ///   - origin: origin of the bar expressed in the magnitude of X-axis. This parameter needs to match the point where
    ///   the center of the bar is located in the X-axis.
    ///   - width: width of the bar expressed in the same magnitude than X-axis.
    ///   - segments: inner segments data. At least one segment needs to be provided.
    ///   - yOffset: it allows to change the origin the bar in the Y-axis. This value needs to be expressed in the magnitude of Y-axis.
    ///   `.zero` by default (the bar starts in y = 0).
    ///   - segmentsStyle: ``KBar/SegmentsStyle`` instance to customize view appearance.
    ///   It is initialized with default parameters by default.
    ///   - labelStyle: ``KBar/LabelStyle``instance to customize label appearance. It is initialized to `.none` by default (no label).
    ///   - accessibilityIdentifier: accessibility identifier for the bar. It is propagated to inner components.
    ///   - accessibilityLabel: accessibility label for the bar.
    public static func vertical(origin: CGFloat,
                                width: CGFloat,
                                segments: [KBar.Segment],
                                yOffset: CGFloat = .zero,
                                segmentsStyle: KBar.SegmentsStyle = KBar.SegmentsStyle(),
                                labelStyle: KBar.LabelStyle = .none,
                                accessibilityIdentifier: String,
                                accessibilityLabel: String) -> KBar {
        KBar(
            origin: CGPoint(x: origin, y: yOffset),
            width: width,
            orientation: .vertical,
            segments: segments,
            segmentsStyle: segmentsStyle,
            labelStyle: labelStyle,
            accessibility: Accessibility(identifier: accessibilityIdentifier, label: accessibilityLabel))
    }

    /// Equatable conformance.
    public static func == (lhs: KBar, rhs: KBar) -> Bool {
        lhs.origin == rhs.origin &&
        lhs.width == rhs.width &&
        lhs.orientation == rhs.orientation &&
        lhs.labelStyle == rhs.labelStyle &&
        lhs.segments == rhs.segments &&
        lhs.accessibility == rhs.accessibility
    }
}

// MARK: - Interaction
extension KBar: KubitChartModelContract {
    func processTap(location: CGPoint,
                    scrollOffset: CGSize,
                    xAxis: KAxis,
                    yAxis: KAxis,
                    canvasSize: CGSize) -> Bool {
        let segmentRects = segmentRects(scrollOffset: scrollOffset, xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize)
        let segment = segmentRects.first { $0.value.contains(location) }
        guard segment != nil else {
            return false
        }
        return true
    }

    func segmentRects(scrollOffset: CGSize,
                      xAxis: KAxis,
                      yAxis: KAxis,
                      canvasSize: CGSize) -> [String: CGRect] {
        var segmentRects: [String: CGRect] = [:]
        var accumulatedValue = orientation.type == .vertical ? origin.y : origin.x
        for segment in segments {
            if orientation.type == .vertical {
                let originX = origin.x.mappedX(axis: xAxis, canvasWidth: canvasSize.width)
                let mappedWidth = width.mappedX(axis: xAxis, canvasWidth: canvasSize.width) - originX
                let initialX = originX - max(12.0, mappedWidth / 2)
                let finalX = originX + max(12.0, mappedWidth / 2)

                let initialY = accumulatedValue.mappedY(axis: yAxis, canvasHeight: canvasSize.height)
                let finalY = (accumulatedValue + segment.value).mappedY(axis: yAxis, canvasHeight: canvasSize.height)
                segmentRects[segment.id] = CGRect(
                    origin: CGPoint(x: min(initialX, finalX), y: min(initialY, finalY)),
                    size: CGSize(width: abs(finalX - initialX), height: abs(finalY - initialY)))
            } else if orientation.type == .horizontal {
                let initialX = accumulatedValue.mappedX(axis: xAxis, canvasWidth: canvasSize.width)
                let finalX = (accumulatedValue + segment.value).mappedX(axis: xAxis, canvasWidth: canvasSize.width)

                let originY = origin.y.mappedY(axis: yAxis, canvasHeight: canvasSize.height)
                let mappedHeight = width.mappedY(axis: yAxis, canvasHeight: canvasSize.height) - originY
                let initialY = originY - max(12.0, mappedHeight / 2)
                let finalY = originY + max(12.0, mappedHeight / 2)
                segmentRects[segment.id] = CGRect(
                    origin: CGPoint(x: min(initialX, finalX), y: min(initialY, finalY)),
                    size: CGSize(width: abs(finalX - initialX), height: abs(finalY - initialY)))
            }
            accumulatedValue += segment.value
        }
        return segmentRects
    }
}

// MARK: - Segments width/height
extension KBar {
    var maxValue: CGFloat {
        segments.map { $0.value }.max() ?? .zero
    }

    var sumOfValues: CGFloat {
        segments.reduce(into: .zero) { result, segment in
            result += segment.value
        }
    }
}

// MARK: - KAxisChart mapping
extension KBar {
    func mappedOrigin(size: CGSize, minPoint: CGPoint, maxPoint: CGPoint) -> CGPoint {
        let mappedX = size.width * (origin.x - minPoint.x) / (maxPoint.x - minPoint.x)
        let mappedY = size.height * (maxPoint.y - origin.y) / (maxPoint.y - minPoint.y)
        return CGPoint(x: mappedX, y: mappedY)
    }

    func mappedWidth(size: CGSize, minPoint: CGPoint, maxPoint: CGPoint) -> CGFloat {
        if orientation == .vertical {
            let totalValues = maxPoint.y - minPoint.y
            let totalHeight = size.height
            let valuePerPixel: CGFloat = totalValues / totalHeight
            return width * valuePerPixel
        } else {
            let totalValues = maxPoint.x - minPoint.x
            let totalWidth = size.width
            let valuePerPixel: CGFloat = totalValues / totalWidth
            return width * valuePerPixel
        }
    }

    func mappedValue(size: CGSize, minPoint: CGPoint, maxPoint: CGPoint) -> CGFloat {
        if orientation == .vertical {
            let totalValues = maxPoint.y - minPoint.y
            let totalHeight = size.height
            let valuePerPixel: CGFloat = totalHeight / totalValues
            return sumOfValues * valuePerPixel
        } else {
            let totalValues = maxPoint.x - minPoint.x
            let totalWidth = size.width
            let valuePerPixel: CGFloat = totalWidth / totalValues
            return sumOfValues * valuePerPixel
        }
    }
}
