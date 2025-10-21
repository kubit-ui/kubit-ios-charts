import KubitCharts
import SwiftUI

struct KIntersectLinePreview: View {
    var body: some View {
        ScrollView {
            VStack {
                examples
            }
        }
        .background(Color(hex: "#F0F0F0") ?? .white)
    }
}

// MARK: - Examples
private extension KIntersectLinePreview {
    var examples: some View {
        VStack {
            Text("Examples")
                .font(.largeTitle)
            horizontal
            vertical
            horizontalAndVertical
        }
    }

    var horizontal: some View {
        KIntersectLineSection(
            title: "Horizontal",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...3),
            horizontal: true)
    }

    var vertical: some View {
        KIntersectLineSection(
            title: "Vertical",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...3),
            vertical: true)
    }

    var horizontalAndVertical: some View {
        KIntersectLineSection(
            title: "Horizontal and Vertical",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...3),
            horizontal: true,
            vertical: true)
    }
}

// MARK: - KIntersectLineSection Section
private struct KIntersectLineSection: View {
    var title: String
    var xAxis: KAxis
    var yAxis: KAxis
    var horizontal = false
    var vertical = false
    var height: CGFloat = 300.0

    @State private var showAlert = false
    @State var textAlert: String = ""

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)

            scatterMap
                .background(Color.white)
                .kRadius(12.0)
                .padding(.horizontal, 12.0)
        }
    }

    var scatterMap: some View {
        let xAxis = SBAxisHelper.defaultAxis(position: .end, label0: "V0", label: "VX")
        let yAxis = SBAxisHelper.defaultAxis(position: .start, label0: "V0", label: "VY")
        return KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
            .addNodes([
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 2.0, y: 2.0), xRadius: 0.2),
                    numberOfVertices: 4,
                    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "Square1")),
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 1.0, y: 2.0), xRadius: 0.2),
                    numberOfVertices: 4,
                    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "Square2")),
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 1.5, y: 2.0), xRadius: 0.2),
                    numberOfVertices: 4,
                    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "Square3")),
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 2.0, y: 2.5), xRadius: 0.2),
                    numberOfVertices: 4,
                    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "Square4")),
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 2.0, y: 3.0), xRadius: 0.2),
                    numberOfVertices: 4,
                    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "Square5")),
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 3.0, y: 4.0), xRadius: 0.2),
                    numberOfVertices: 4,
                    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "Square6")),
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 3.0, y: 4.5), xRadius: 0.2),
                    numberOfVertices: 4,
                    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "Square7")),
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 4.0, y: 6.0), xRadius: 0.2),
                    numberOfVertices: 4,
                    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "Square8")),
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 6.0, y: 7.0), xRadius: 0.2),
                    numberOfVertices: 4,
                    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "Square9")),
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 6.0, y: 8.0), xRadius: 0.2),
                    numberOfVertices: 4,
                    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "Square10"))
            ])
            .setHorizontalIntersectLine(color: horizontal ? Color.green : nil)
            .setVerticalIntersectLine(color: vertical ? Color.green : nil)
            .frame(maxWidth: .infinity)
            .frame(height: 300.0)
            .padding()
            .background(Color.white)
            .kRadius(12.0)
            .padding(.horizontal, 12.0)
    }
}

// MARK: - Preview
#if DEBUG
#Preview {
    KIntersectLinePreview()
}
#endif

