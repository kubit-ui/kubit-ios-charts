import SwiftUI

extension View {
    @ViewBuilder
    func charts(xAxis: KAxis,
                yAxis: KAxis,
                models: [KubitChartModelContract],
                selectedNode: KNode?,
                paddings: KAxisChart.InnerPaddings,
                scrollOffset: CGSize,
                height: Binding<CGFloat?>) -> some View {
        if models.isEmpty {
            self
        } else {
            ZStack {
                self

                ForEach(models.indices, id: \.self) { index in
                    if let bar = models[index] as? KBar {
                        KBarView(xAxis: xAxis, yAxis: yAxis, bar: bar, scrollOffset: scrollOffset)
                    } else if let background = models[index] as? KCustomBackground {
                        KCustomBackgroundView(
                            xAxis: xAxis,
                            yAxis: yAxis,
                            background: background,
                            scrollOffset: scrollOffset,
                            height: height)
                    } else if let node = models[index] as? KNode {
                        KNodeView(xAxis: xAxis, yAxis: yAxis, node: node, scrollOffset: scrollOffset)
                    } else if let line = models[index] as? KLine {
                        KLineView(xAxis: xAxis, yAxis: yAxis, line: line, scrollOffset: scrollOffset)
                    } else if let area = models[index] as? KArea {
                        KAreaView(xAxis: xAxis, yAxis: yAxis, area: area, scrollOffset: scrollOffset)
                    } else if let selectedNode, let intersectLine = models[index] as? KIntersectLine {
                        KIntersectLineView(
                            xAxis: xAxis,
                            yAxis: yAxis,
                            selectedNode: selectedNode,
                            intersectLine: intersectLine,
                            scrollOffset: scrollOffset)
                    }
                }
                .padding(.leading, paddings.leading)
                .padding(.trailing, paddings.trailing)
                .padding(.top, paddings.top)
                .padding(.bottom, paddings.bottom)
            }
        }
    }
}
