// swiftlint:disable:this file_name
import SwiftUI

extension AxisGrid {
    struct AccessibleLinesView: View {
        var xAxis: KAxis
        var yAxis: KAxis
        var size: CGSize

        var body: some View {
            let yAxisHeight = yAxis.realAxisHeight(canvasHeight: size.height)
            let xAxisWidth = xAxis.realAxisWidth(canvasWidth: size.width)
            ZStack {
                let xLines = xAxis.xLines(for: size, yAxisHeight: yAxisHeight)
                ForEach(xLines.indices, id: \.self) { index in
                    AccessibleLineView(index: index, line: xLines[index], axis: xAxis)
                }
                let yLines = yAxis.yLines(for: size, xAxisWidth: xAxisWidth)
                ForEach(yLines.indices, id: \.self) { index in
                    AccessibleLineView(index: index, line: yLines[index], axis: yAxis)
                }
            }
        }

        private struct AccessibleLineView: View {
            let index: Int
            let line: KAxis.LineData
            let axis: KAxis

            var body: some View {
                if let accessibility = axis.points[index].accessibility, accessibility.isAccessible {
                    Path { path in
                        path.move(to: line.origin)
                        path.addLine(to: line.end)
                    }
                    .strokedPath(StrokeStyle(lineWidth: 30, lineCap: .round))
                    .fill(.black.opacity(0.001))
                    .accessibilityIdentifier(accessibility.identifier)
                    .accessibilityLabel(accessibility.label ?? "")
                    .accessibilityHint(accessibility.hint ?? "")
                    .accessibilityValue(accessibility.value ?? "")
                }
            }
        }
    }
}

extension KNodeView {
    struct AccessibleNodeView: View {
        var xAxis: KAxis
        var yAxis: KAxis
        var node: KNode
        var scrollOffset: CGSize
        var size: CGSize

        var body: some View {
            if node.accessibility.isAccessible {
                let mappedZero = CGFloat.zero.mappedX(axis: xAxis, canvasWidth: size.width)
                let mappedCenter = node.shape.unmappedCenter.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size)
                let mappedRadius = node.shape.unmappedXRadius.mappedX(axis: xAxis, canvasWidth: size.width)
                AccessibleNodeView(
                    center: mappedCenter,
                    radius: mappedRadius - mappedZero,
                    node: node,
                    size: size)
            }
        }

        private struct AccessibleNodeView: View {
            let center: CGPoint
            let radius: CGFloat
            var node: KNode
            let size: CGSize

            var body: some View {
                Path { path in
                    path.addArc(
                        center: center,
                        radius: radius,
                        startAngle: .zero,
                        endAngle: Angle(degrees: 360.0),
                        clockwise: true)
                }
                .strokedPath(StrokeStyle(lineWidth: radius * 2, lineCap: .round))
                .fill(.black.opacity(0.001))
                .accessibilityIdentifier(node.accessibility.identifier)
                .accessibilityLabel(node.accessibility.label ?? "")
                .accessibilityHint(node.accessibility.hint ?? "")
                .accessibilityValue(node.accessibility.value ?? "")
            }
        }
    }
}
