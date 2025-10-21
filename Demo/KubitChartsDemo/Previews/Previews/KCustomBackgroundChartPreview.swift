import KubitCharts
import SwiftUI

struct KCustomBackgroundChartPreview: View {
    var clearAxis: KAxis {
        KAxisBuilder()
            .addPointWithClearLine(0.0)
            .addPointWithClearLine(10.0)
            .build()
    }

    var body: some View {
        ScrollView {
            VStack {
                variants
            }
        }
        .background(Color(hex: "#F0F0F0") ?? .white)
    }
}

// MARK: - Variants
private extension KCustomBackgroundChartPreview {
    var variants: some View {
        VStack {
            Text("Variants")
                .font(.largeTitle)
            local
            remote
        }
    }

    var local: some View {
        VStack {
            Text("Local source")
                .font(.headline)

            KAxisChart()
                .xAxis(clearAxis)
                .yAxis(clearAxis)
                .addBackground(KCustomBackground(
                    source: .local(name: "map", bundle: nil),
                    accessibilityIdentifier: "LocalSourceIdentifier"))
                .background(Color.white)
                .kRadius(12.0)
                .padding(.horizontal, 12.0)
        }
    }

    var remote: some View {
        VStack {
            Text("Remote source")
                .font(.headline)

            KAxisChart()
                .xAxis(clearAxis)
                .yAxis(clearAxis)
                .addBackground(KCustomBackground(
                    source: .remote(url: URL(string: "https://www.openbank.es/assets/2024-12/mbServiceInfo_1_Robo.jpg")),
                    accessibilityIdentifier: "RemoteSourceIdentifier"))
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .kRadius(12.0)
                .padding(.horizontal, 12.0)
        }
    }
}

// MARK: - Preview
#if DEBUG
#Preview {
    KCustomBackgroundChartPreview()
}
#endif
