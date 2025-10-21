import KubitCharts
import SwiftUI

struct KZoomAreaChartPreview: View {
    var body: some View {
        lineChartPlusZoomArea
            .background(Color.white)
    }
}

// MARK: - Appearance
private extension KZoomAreaChartPreview {
    var lineChartPlusZoomArea: some View {
        KZoomAreaChartSection(title: "Line Chart + ZoomChartArea")
    }
}

// MARK: - Line Chart Section
private struct KZoomAreaChartSection: View {
    var title: String
    var xAxis: KAxis = SBAxisHelper.clearAxis()
    var yAxis: KAxis = SBAxisHelper.clearAxis()

    @State private var startHandle: Double = 0.2
    @State private var endHandle: Double = 0.8

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            lineChart
                .padding(.horizontal, 10)
            zoomAreaChart
                .padding(10)
        }
    }

    var lineChart: some View {
        KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
            .addLines([zoomLine])
            .frame(height: 300)
    }

    var previewChart: some View {
        KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
            .addLines([zoomLine])
    }

    var zoomAreaChart: some View {
        KZoomAreaChart(
            startHandle: $startHandle,
            endHandle: $endHandle,
            content: { previewChart },
            opacityColor: Color.blue)
        .frame(height: 40)
    }

    var zoomLine: KLine {
        let points: [CGPoint] = [
            CGPoint.zero,
            CGPoint(x: 1.0, y: 1),
            CGPoint(x: 2.0, y: 2),
            CGPoint(x: 3.0, y: 3),
            CGPoint(x: 4.0, y: 4),
            CGPoint(x: 5.0, y: 5),
            CGPoint(x: 6.0, y: 2),
            CGPoint(x: 7.0, y: 7),
            CGPoint(x: 8.0, y: 8),
            CGPoint(x: 9.0, y: 3),
            CGPoint(x: 10.0, y: 0)]
        return KLine(
            points: points,
            appearance: .rounded,
            style: .solid(width: 2.0, color: Color(hex: "#CC3E42")!, decoration: .none),
            zoomable: KLine.Zoomable(startHandle: startHandle, endHandle: endHandle, points: points),
            accessibilityIdentifier: "lineWithBackgroundIdentifier")
    }
}

// MARK: - Preview
#if DEBUG
#Preview {
    KZoomAreaChartPreview()
}
#endif
