public import SwiftUI

/// #  KAxisChart
///
/// A configurable chart component that displays information in an X-Y coordinate system.
///
/// [Figma design]
/// (figma.com/design/n9UUfTNerkDed8GBQMb6RM/(MAIN)-Kubit-Global-Documentation?node-id=58382-6841&t=GJCLUna1smNJ1Uyk-0)
///
/// ## How to use it:
/// ```swift
/// let xAxis = KAxisBuilder()
///     .addPointWithDefaultSolidLine(0, labelStyle: .labeled("0"))
///     .addPointWithDefaultSolidLine(100, labelStyle: .labeled("100"))
///     .setLabelsViewPosition(.start)
///     .build()
///
/// let yAxis = KAxisBuilder()
///     .addPointWithDefaultSolidLine(0, labelStyle: .labeled("0"))
///     .addPointWithDefaultSolidLine(100, labelStyle: .labeled("100"))
///     .setLabelsViewPosition(.start)
///     .build()
///
/// // Create and setup chart
/// KAxisChart()
///     .xAxis(xAxis)
///     .yAxis(yAxis)
/// ```
public struct KAxisChart: View {
    @ObservedObject var charts: ChartsModel
    @ObservedObject var model: DataModel

    @State private var height: CGFloat?
    @State private var scrollOffset: CGSize = .zero
    @State private var prevOffset: CGSize = .zero
    @State private var maximumOffsetX: CGFloat = .zero
    @State private var minimumOffsetX: CGFloat = .zero
    @State private var maximumOffsetY: CGFloat = .zero
    @State private var minimumOffsetY: CGFloat = .zero

    /// It initializes and configures this component.
    public init() {
        self.model = DataModel()
        self.charts = ChartsModel()
    }

    public var body: some View {
        ZStack {
            Color.clear
                .axes(xAxis: xAxis, yAxis: yAxis, chartPaddings: chartPaddings, scrollOffset: scrollOffset)
                .shade(regions: shadeRegions, xAxis: xAxis, yAxis: yAxis, paddings: chartPaddings, scrollOffset: scrollOffset)
                .charts(
                    xAxis: xAxis,
                    yAxis: yAxis,
                    models: charts.models,
                    selectedNode: charts.selectedNode,
                    paddings: chartPaddings,
                    scrollOffset: scrollOffset,
                    height: $height)

            if isDraggable {
                draggableAndTappableHelperView
            }
        }
        .frame(height: height)
    }
}

// MARK: - Inner Views
private extension KAxisChart {
    var draggableAndTappableHelperView: some View {
        GeometryReader { proxy in
            Rectangle()
                .fill(Color.clear)
                .contentShape(Rectangle())
                .background(GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            guard isDraggable else {
                                return
                            }
                            DispatchQueue.main.async {
                                let rect = proxy.frame(in: .local)
                                calculateXOffsets(size: rect.size)
                                calculateYOffsets(size: rect.size)
                                calculateInitialOffsets(size: rect.size)
                            }
                        }
                })
                .if(isDraggable) { content in
                    content
                        .gesture(DragGesture(minimumDistance: 10.0, coordinateSpace: .global)
                            .onChanged { value in
                                if case .scrollable = xAxis.behavior.type {
                                    var widthOffset = self.prevOffset.width + value.translation.width
                                    if widthOffset > maximumOffsetX {
                                        widthOffset = maximumOffsetX
                                    } else if widthOffset < minimumOffsetX {
                                        widthOffset = minimumOffsetX
                                    }
                                    self.scrollOffset.width = widthOffset
                                }
                                if case .scrollable = yAxis.behavior.type {
                                    var heightOffset = self.prevOffset.height + value.translation.height
                                    if heightOffset > maximumOffsetY {
                                        heightOffset = maximumOffsetY
                                    } else if heightOffset < minimumOffsetY {
                                        heightOffset = minimumOffsetY
                                    }
                                    self.scrollOffset.height = heightOffset
                                }
                            }
                            .onEnded { _ in
                                self.prevOffset = self.scrollOffset
                            })
                    // TODO: MagnifyGesture is available on iOS 17+
                }
                .simultaneousGesture(DragGesture(minimumDistance: 0)
                    .onEnded { gesture in
                        let location = gesture.location
                        guard (CGFloat.zero...proxy.size.width).contains(location.x),
                              (CGFloat.zero...proxy.size.height).contains(location.y),
                              gesture.startLocation == gesture.location
                        else {
                            return
                        }
                        processTap(at: location, size: proxy.size)
                    })
        }
        .padding(.leading, chartPaddings.leading)
        .padding(.trailing, chartPaddings.trailing)
        .padding(.top, chartPaddings.top)
        .padding(.bottom, chartPaddings.bottom)
    }
}

// MARK: - Chart paddings
extension KAxisChart {
    var chartPaddings: KAxisChart.InnerPaddings {
        var leadingPadding: CGFloat = yAxis.labelsStyle.minSize.width / 2
        var trailingPadding: CGFloat = yAxis.labelsStyle.minSize.width / 2
        var topPadding: CGFloat = xAxis.labelsStyle.minSize.height / 2
        var bottomPadding: CGFloat = xAxis.labelsStyle.minSize.height / 2

        if yLabelsPosition == .start, yAxis.hasLabels {
            leadingPadding = yAxis.labelsStyle.minSize.width
        }
        if yLabelsPosition == .end, yAxis.hasLabels {
            trailingPadding = yAxis.labelsStyle.minSize.width
        }

        if xLabelsPosition == .start, xAxis.hasLabels {
            topPadding = xAxis.labelsStyle.minSize.height
        }
        if xLabelsPosition == .end, xAxis.hasLabels {
            bottomPadding = xAxis.labelsStyle.minSize.height
        }

        return KAxisChart.InnerPaddings(
            top: topPadding,
            leading: leadingPadding,
            bottom: bottomPadding,
            trailing: trailingPadding)
    }
}

// MARK: - Private functions
private extension KAxisChart {
    var isDraggable: Bool {
        if case .scrollable = xAxis.behavior.type {
            return true
        }
        if case .scrollable = yAxis.behavior.type {
            return true
        }
        return false
    }

    func calculateXOffsets(size: CGSize) {
        guard case let .scrollable(pointsSpacing, _) = xAxis.behavior.type,
              xAxis.fullRange * pointsSpacing > size.width - chartPaddings.horizontal
        else {
            return
        }
        let totalWidth = xAxis.fullRange * pointsSpacing
        minimumOffsetX = -(totalWidth - size.width + chartPaddings.horizontal)
        maximumOffsetX = .zero
    }

    func calculateYOffsets(size: CGSize) {
        guard case let .scrollable(pointsSpacing, _) = yAxis.behavior.type,
              yAxis.fullRange * pointsSpacing > size.height - chartPaddings.vertical
        else {
            return
        }
        let totalHeight = yAxis.fullRange * pointsSpacing
        minimumOffsetY = .zero
        maximumOffsetY = totalHeight - size.height + chartPaddings.vertical
    }

    func calculateInitialOffsets(size: CGSize) {
        guard isDraggable else {
            return
        }

        var widthOffset: CGFloat = .zero
        var heightOffset: CGFloat = .zero
        if case let .scrollable(pointsSpacing, centerValue) = xAxis.behavior.type,
           let centerValue,
           xAxis.minValue < centerValue,
           xAxis.maxValue > centerValue {
            let currentWidth = size.width - chartPaddings.horizontal
            let currentCenter = currentWidth / 2
            let centerValueOffset = (centerValue - xAxis.minValue) * pointsSpacing
            widthOffset = currentCenter - centerValueOffset
        }
        if case let .scrollable(pointsSpacing, centerValue) = yAxis.behavior.type,
           let centerValue,
           yAxis.minValue < centerValue,
           yAxis.maxValue > centerValue {
            let currentHeight = size.height - chartPaddings.vertical
            let currentCenter = currentHeight / 2
            let centerValueOffset = (centerValue - yAxis.minValue) * pointsSpacing
            heightOffset = centerValueOffset - currentCenter
        }

        if widthOffset > maximumOffsetX {
            widthOffset = maximumOffsetX
        } else if widthOffset < minimumOffsetX {
            widthOffset = minimumOffsetX
        }
        self.scrollOffset.width = widthOffset
        self.prevOffset.width = widthOffset

        if heightOffset > maximumOffsetY {
            heightOffset = maximumOffsetY
        } else if heightOffset < minimumOffsetY {
            heightOffset = minimumOffsetY
        }
        self.scrollOffset.height = heightOffset
        self.prevOffset.height = heightOffset
    }
}

// MARK: - Interaction
private extension KAxisChart {
    func processTap(at location: CGPoint, size: CGSize) {
        _ = charts.models.reversed().first(where: { model in
            let tapped = model.processTap(
                location: location,
                scrollOffset: scrollOffset,
                xAxis: xAxis,
                yAxis: yAxis,
                canvasSize: size)

            if tapped, let node = model as? KNode {
                if charts.selectedNode != node {
                    print("selectedNode \(node)") // swiftlint:disable:this disable_print
                    charts.selectedNode = node
                    charts.didSelectNode?(node)
                } else if let selectedNode = charts.selectedNode {
                    print("unselectedNode \(node)") // swiftlint:disable:this disable_print
                    charts.didUnselectNode?(selectedNode)
                    charts.selectedNode = nil
                }
                return true
            } else if tapped, let bar = model as? KBar {
                charts.didTapOnBar?(bar)
                return true
            }
            return tapped
        })
    }
}

// MARK: - Shortcuts
private extension KAxisChart {
    var xAxis: KAxis {
        model.xAxis
    }

    var yAxis: KAxis {
        model.yAxis
    }

    var xLabelsPosition: KAxis.LabelsStyle.Position {
        xAxis.labelsStyle.position
    }

    var yLabelsPosition: KAxis.LabelsStyle.Position {
        yAxis.labelsStyle.position
    }

    var xPoints: [KAxis.Point] {
        xAxis.points
    }

    var yPoints: [KAxis.Point] {
        yAxis.points
    }

    var shadeRegions: [KShadeRegion] {
        model.shadeRegions
    }
}

#if DEBUG
struct KAxisChartPreview: View {
    var xAxis: KAxis {
        KAxis(
            behavior: .scrollable(pointsSpacing: 50.0, centerValue: 0.0),
            points: [
                KAxis.Point(-5),
                KAxis.Point(-4, labelStyle: .labeled("-4"), lineStyle: .dashed()),
                KAxis.Point(-3, labelStyle: .labeled("-3"), lineStyle: .dashed()),
                KAxis.Point(-2, labelStyle: .labeled("-2"), lineStyle: .dashed()),
                KAxis.Point(-1, labelStyle: .labeled("-1"), lineStyle: .dashed()),
                KAxis.Point(0, labelStyle: .labeled("0", color: .black), lineStyle: .solid(width: 2.0, color: .black)),
                KAxis.Point(1, labelStyle: .labeled("1"), lineStyle: .dashed()),
                KAxis.Point(2, labelStyle: .labeled("2"), lineStyle: .dashed()),
                KAxis.Point(3, labelStyle: .labeled("3"), lineStyle: .dashed()),
                KAxis.Point(4, labelStyle: .labeled("4"), lineStyle: .dashed()),
                KAxis.Point(5)],
            labelsStyle: KAxis.LabelsStyle(position: .start))
    }

    var yAxis: KAxis {
        KAxis(
            behavior: .scrollable(pointsSpacing: 100.0, centerValue: 0.0),
            points: [
                KAxis.Point(-5),
                KAxis.Point(-4, labelStyle: .labeled("-4"), lineStyle: .dashed()),
                KAxis.Point(-3, labelStyle: .labeled("-3"), lineStyle: .dashed()),
                KAxis.Point(-2, labelStyle: .labeled("-2"), lineStyle: .dashed()),
                KAxis.Point(-1, labelStyle: .labeled("-1"), lineStyle: .dashed()),
                KAxis.Point(0, labelStyle: .labeled("0", color: .black), lineStyle: .solid(width: 2.0, color: .black)),
                KAxis.Point(1, labelStyle: .labeled("1"), lineStyle: .dashed()),
                KAxis.Point(2, labelStyle: .labeled("2"), lineStyle: .dashed()),
                KAxis.Point(3, labelStyle: .labeled("3"), lineStyle: .dashed()),
                KAxis.Point(4, labelStyle: .labeled("4"), lineStyle: .dashed()),
                KAxis.Point(5)],
            labelsStyle: KAxis.LabelsStyle(position: .end))
    }

    var verticalBar: KBar {
        .vertical(
            origin: 1.0,
            width: 0.8,
            segments: [
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 2.0,
                    accessibilityLabel: "Acc label for bar 1 segment 1",
                    accessibilityValue: "2 points"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 1.0,
                    accessibilityLabel: "Acc label for bar 1 segment 2",
                    accessibilityValue: "1 points"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 0.5,
                    accessibilityLabel: "Acc label for bar 1 segmnet 3",
                    accessibilityValue: "0.5 points")
            ],
            yOffset: .zero,
            segmentsStyle: KBar.SegmentsStyle(),
            accessibilityIdentifier: "Bar1",
            accessibilityLabel: "Bar 1")
    }

    var horizontalBar: KBar {
        .horizontal(
            origin: 1.0,
            height: 0.8,
            segments: [
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 2.0,
                    accessibilityLabel: "Acc label for bar 1 segment 1",
                    accessibilityValue: "2 points"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 1.0,
                    accessibilityLabel: "Acc label for bar 1 segment 2",
                    accessibilityValue: "1 points"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 0.5,
                    accessibilityLabel: "Acc label for bar 1 segmnet 3",
                    accessibilityValue: "0.5 points")
            ],
            xOffset: .zero,
            segmentsStyle: KBar.SegmentsStyle(),
            accessibilityIdentifier: "Bar1",
            accessibilityLabel: "Bar 1")
    }

    var body: some View {
        KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
            .addNegativeShadeRegions(color: Color.pink.opacity(0.5))
            .addBar(horizontalBar)
            .padding(16.0)
    }
}

#Preview {
    KAxisChartPreview()
}
#endif
// swiftlint:disable:this file_length
