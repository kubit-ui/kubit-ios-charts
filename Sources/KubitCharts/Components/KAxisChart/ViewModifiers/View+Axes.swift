import SwiftUI

struct AxisGrid: ViewModifier {
    var xAxis: KAxis
    var yAxis: KAxis
    var chartPaddings: KAxisChart.InnerPaddings
    var scrollOffset: CGSize

    func body(content: Content) -> some View {
        ZStack {
            axisGrid
                .padding(.leading, chartPaddings.leading)
                .padding(.trailing, chartPaddings.trailing)
                .padding(.top, chartPaddings.top)
                .padding(.bottom, chartPaddings.bottom)

            xAxisLabels
            yAxisLabels

            content
                .padding(.leading, chartPaddings.leading)
                .padding(.trailing, chartPaddings.trailing)
                .padding(.top, chartPaddings.top)
                .padding(.bottom, chartPaddings.bottom)
        }
    }
}

// MARK: - Inner Views
private extension AxisGrid {
    var axisGrid: some View {
        ZStack {
            Canvas { context, size in
                context.translateBy(x: scrollOffset.width, y: scrollOffset.height)
                let yAxisHeight = yAxis.realAxisHeight(canvasHeight: size.height)
                context.drawAxis(axis: xAxis, size: size, lines: xAxis.xLines(for: size, yAxisHeight: yAxisHeight))
                let xAxisWidth = xAxis.realAxisWidth(canvasWidth: size.width)
                context.drawAxis(axis: yAxis, size: size, lines: yAxis.yLines(for: size, xAxisWidth: xAxisWidth))
            }
            GeometryReader { geo in
                AccessibleLinesView(xAxis: xAxis, yAxis: yAxis, size: geo.size)
            }
        }
    }

    var xAxisLabels: some View {
        VStack(spacing: 0.0) {
            if xAxis.labelsStyle.position == .end {
                Spacer()
            }

            if xAxis.labelsStyle.position != .none {
                Canvas { context, size in
                    let yAxisHeight = yAxis.realAxisHeight(canvasHeight: size.height)

                    var customPosition: CGFloat?
                    let anchor: UnitPoint
                    if case let .custom(value, labelsOffset) = xAxis.labelsStyle.position.type, value >= 0, value <= 1 {
                        context.translateBy(x: scrollOffset.width, y: scrollOffset.height)
                        customPosition = size.height - yAxisHeight * value + labelsOffset
                        anchor = .center
                    } else {
                        context.translateBy(x: scrollOffset.width, y: .zero)
                        anchor = xAxis.labelsStyle.position == .start ? .bottom : .top
                    }
                    let xLines = xAxis.xLines(for: size, yAxisHeight: yAxisHeight)
                    let labelPoints = xLines.map { line in
                        line.xLabelPoint(
                            axis: xAxis,
                            customPosition: customPosition,
                            startPadding: chartPaddings.leading,
                            endPadding: chartPaddings.trailing,
                            size: size)
                    }
                    context.drawLabels(
                        axis: xAxis,
                        size: size,
                        labelPoints: labelPoints,
                        anchor: anchor)
                }
                .frame(height: [.start, .end].contains(xAxis.labelsStyle.position) ? xAxis.labelsStyle.minSize.height : nil)
            }

            if xAxis.labelsStyle.position == .start {
                Spacer()
            }
        }
    }

    var yAxisLabels: some View {
        HStack(spacing: .zero) {
            if yAxis.labelsStyle.position == .end {
                Spacer()
            }

            if yAxis.labelsStyle.position != .none {
                Canvas { context, size in
                    let xAxisWidth = xAxis.realAxisWidth(canvasWidth: size.width)

                    var customPosition: CGFloat?
                    let anchor: UnitPoint
                    if case let .custom(value, labelsOffset) = yAxis.labelsStyle.position.type, value >= 0, value <= 1 {
                        customPosition = xAxisWidth * value + labelsOffset
                        context.translateBy(x: scrollOffset.width, y: scrollOffset.height)
                        anchor = .leading
                    } else {
                        context.translateBy(x: .zero, y: scrollOffset.height)
                        anchor = yAxis.labelsStyle.position == .start ? .trailing : .leading
                    }
                    let yLines = yAxis.yLines(for: size, xAxisWidth: xAxisWidth)
                    let labelPoints = yLines.map { line in
                        line.yLabelPoint(
                            axis: yAxis,
                            customPosition: customPosition,
                            startPadding: chartPaddings.top,
                            endPadding: chartPaddings.bottom,
                            size: size)
                    }
                    context.drawLabels(
                        axis: yAxis,
                        size: size,
                        labelPoints: labelPoints,
                        anchor: anchor)
                }
                .frame(width: [.start, .end].contains(yAxis.labelsStyle.position) ? yAxis.labelsStyle.minSize.width : nil)
            }

            if yAxis.labelsStyle.position == .start {
                Spacer()
            }
        }
    }
}

extension View {
    func axes(xAxis: KAxis,
              yAxis: KAxis,
              chartPaddings: KAxisChart.InnerPaddings,
              scrollOffset: CGSize) -> some View {
        modifier(AxisGrid(xAxis: xAxis, yAxis: yAxis, chartPaddings: chartPaddings, scrollOffset: scrollOffset))
    }
}
