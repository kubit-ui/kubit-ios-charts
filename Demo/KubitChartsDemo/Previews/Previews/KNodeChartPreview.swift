import KubitCharts
import SwiftUI

struct KNodeChartPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                shapes
                halos
                examples
            }
        }
        .background(Color(hex: "#F0F0F0") ?? .white)
    }
}

// MARK: - Shapes
private extension KNodeChartPreview {
    var shapes: some View {
        VStack {
            Text("Shapes")
                .font(.largeTitle)
            circle
            square
            star5
            star8
            triangle
            custom
            cross
        }
    }

    var circle: some View {
        KNodeChartSection(
            title: "Circle",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...3),
            nodes: [
                .circle(
                    position: KShape.Position(center: CGPoint(x: 5.0, y: 1.5), xRadius: 0.5),
                    style: KShape.Style(fillColor: Color.green.opacity(0.2), borderColor: Color.green, borderWidth: 2.0),
                    accessibility: .decorative(identifier: "CircleNode"))
            ],
            height: 60.0)
    }

    var square: some View {
        KNodeChartSection(
            title: "Square",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...3),
            nodes: [
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 5.0, y: 1.5), xRadius: 0.5),
                    numberOfVertices: 4,
                    style: KShape.Style(fillColor: Color.green.opacity(0.2), borderColor: Color.green, borderWidth: 2.0),
                    accessibility: .decorative(identifier: "SquareNode"))
            ],
            height: 60.0)
    }

    var star5: some View {
        KNodeChartSection(
            title: "Star (5)",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...3),
            nodes: [
                .star(
                    position: KShape.Position(center: CGPoint(x: 5.0, y: 1.5), xRadius: 0.5, rotation: Angle(degrees: 52.5)),
                    style: KShape.Style(fillColor: Color.green.opacity(0.2), borderColor: Color.green, borderWidth: 2.0),
                    accessibility: .decorative(identifier: "StarNode"))
            ],
            height: 60.0)
    }

    var star8: some View {
        KNodeChartSection(
            title: "Star (8)",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...3),
            nodes: [
                .star(
                    position: KShape.Position(center: CGPoint(x: 5.0, y: 1.5), xRadius: 0.5),
                    numberOfVertices: 8,
                    style: KShape.Style(fillColor: Color.green.opacity(0.2), borderColor: Color.green, borderWidth: 2.0),
                    accessibility: .decorative(identifier: "Star8Node"))
            ],
            height: 60.0)
    }

    var triangle: some View {
        KNodeChartSection(
            title: "Triangle",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...3),
            nodes: [
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 5.0, y: 1.5), xRadius: 0.5, rotation: Angle(degrees: 270.0)),
                    numberOfVertices: 3,
                    style: KShape.Style(fillColor: Color.green.opacity(0.2), borderColor: Color.green, borderWidth: 2.0),
                    accessibility: .decorative(identifier: "TriangleNode"))
            ],
            height: 60.0)
    }

    var pentagon: some View {
        KNodeChartSection(
            title: "Pentagon",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...3),
            nodes: [
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 5.0, y: 1.5), xRadius: 0.5, rotation: Angle(degrees: 270.0)),
                    numberOfVertices: 5,
                    style: KShape.Style(fillColor: Color.green.opacity(0.2), borderColor: Color.green, borderWidth: 2.0),
                    accessibility: .decorative(identifier: "PentagonNode"))
            ],
            height: 60.0)
    }

    var custom: some View {
        var path = Path()
        path.move(to: CGPoint(x: 3.5, y: 1.35))
        path.addLine(to: CGPoint(x: 3.5, y: 1.65))
        path.addLine(to: CGPoint(x: 6.5, y: 1.65))
        path.addLine(to: CGPoint(x: 6.5, y: 1.35))
        path.closeSubpath()

        return KNodeChartSection(
            title: "Custom",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...3),
            nodes: [
                .custom(
                    path: path,
                    center: CGPoint(x: 5.0, y: 1.5),
                    xRadius: 1.5,
                    style: KShape.Style(fillColor: Color.green.opacity(0.2), borderColor: Color.green, borderWidth: 2.0),
                    accessibility: .decorative(identifier: "CustomNode"))
            ],
            height: 60.0)
    }

    var cross: some View {
        KNodeChartSection(
            title: "Cross",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...3),
            nodes: [
                .cross(
                    position: KShape.Position(center: CGPoint(x: 5.0, y: 1.5), xRadius: 0.5, rotation: Angle(degrees: 270.0)),
                    style: KShape.Style(fillColor: Color.green.opacity(0.2), borderColor: Color.green, borderWidth: 2.0),
                    accessibility: .decorative(identifier: "CrossNode"))
            ],
            height: 60.0)
    }
}

// MARK: - Halos
private extension KNodeChartPreview {
    var halos: some View {
        VStack {
            Text("Halos")
                .font(.largeTitle)
            circleWithHalo
            squareWithHalo
            star5WithHalo
            star8WithHalo
            triangleWithHalo
            crossWithHalo
        }
    }

    var circleWithHalo: some View {
        KNodeChartSection(
            title: "Circle with halo",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...4),
            nodes: [
                .circle(
                    position: KShape.Position(center: CGPoint(x: 5.0, y: 2.0), xRadius: 0.35, haloWidth: 0.2),
                    style: KShape.Style(
                        fillColor: Color.green.opacity(0.2),
                        borderColor: Color.green,
                        borderWidth: 2.0,
                        haloColor: Color.gray.opacity(0.2)),
                    accessibility: .decorative(identifier: "CircleNode"))
            ],
            height: 60.0)
    }

    var squareWithHalo: some View {
        KNodeChartSection(
            title: "Square with halo",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...4),
            nodes: [
                .polygon(
                    position: KShape.Position(center: CGPoint(x: 5.0, y: 2.0), xRadius: 0.35, haloWidth: 0.2),
                    numberOfVertices: 4,
                    style: KShape.Style(
                        fillColor: Color.green.opacity(0.2),
                        borderColor: Color.green,
                        borderWidth: 2.0,
                        haloColor: Color.gray.opacity(0.2)),
                    accessibility: .decorative(identifier: "SquareNode"))
            ],
            height: 60.0)
    }

    var star5WithHalo: some View {
        KNodeChartSection(
            title: "Star (5) with halo",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...4),
            nodes: [
                .star(
                    position: KShape.Position(
                        center: CGPoint(x: 5.0, y: 2.0),
                        xRadius: 0.35,
                        rotation: Angle(degrees: 52.5),
                        haloWidth: 0.2),
                    style: KShape.Style(
                        fillColor: Color.green.opacity(0.2),
                        borderColor: Color.green,
                        borderWidth: 2.0,
                        haloColor: Color.gray.opacity(0.2)),
                    accessibility: .decorative(identifier: "StarNode"))
            ],
            height: 60.0)
    }

    var star8WithHalo: some View {
        KNodeChartSection(
            title: "Star (8) with halo",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...4),
            nodes: [
                .star(
                    position: KShape.Position(center: CGPoint(x: 5.0, y: 2.0), xRadius: 0.35, haloWidth: 0.2),
                    numberOfVertices: 8,
                    style: KShape.Style(
                        fillColor: Color.green.opacity(0.2),
                        borderColor: Color.green,
                        borderWidth: 2.0,
                        haloColor: Color.gray.opacity(0.2)),
                    accessibility: .decorative(identifier: "Star8Node"))
            ],
            height: 60.0)
    }

    var triangleWithHalo: some View {
        KNodeChartSection(
            title: "Triangle with halo",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...4),
            nodes: [
                .polygon(
                    position: KShape.Position(
                        center: CGPoint(x: 5.0, y: 2.0),
                        xRadius: 0.35,
                        rotation: Angle(degrees: 270.0),
                        haloWidth: 0.2),
                    numberOfVertices: 3,
                    style: KShape.Style(
                        fillColor: Color.green.opacity(0.2),
                        borderColor: Color.green,
                        borderWidth: 2.0,
                        haloColor: Color.gray.opacity(0.2)),
                    accessibility: .decorative(identifier: "TriangleNode"))
            ],
            height: 60.0)
    }

    var pentagonWithHalo: some View {
        KNodeChartSection(
            title: "Pentagon with halo",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...4),
            nodes: [
                .polygon(
                    position: KShape.Position(
                        center: CGPoint(x: 5.0, y: 2.0),
                        xRadius: 0.35,
                        rotation: Angle(degrees: 270.0),
                        haloWidth: 0.2),
                    numberOfVertices: 5,
                    style: KShape.Style(
                        fillColor: Color.green.opacity(0.2),
                        borderColor: Color.green,
                        borderWidth: 2.0,
                        haloColor: Color.gray.opacity(0.2)),
                    accessibility: .decorative(identifier: "PentagonNode"))
            ],
            height: 60.0)
    }

    var crossWithHalo: some View {
        KNodeChartSection(
            title: "Cross with halo",
            xAxis: SBAxisHelper.clearAxis(),
            yAxis: SBAxisHelper.clearAxis(0...4),
            nodes: [
                .cross(
                    position: KShape.Position(
                        center: CGPoint(x: 5.0, y: 2.0),
                        xRadius: 0.35,
                        rotation: Angle(degrees: 270.0),
                        haloWidth: 0.2),
                    style: KShape.Style(
                        fillColor: Color.green.opacity(0.2),
                        borderColor: Color.green,
                        borderWidth: 2.0,
                        haloColor: Color.gray.opacity(0.2)),
                    accessibility: .decorative(identifier: "CrossNode"))
            ],
            height: 60.0)
    }
}

// MARK: - Examples
private extension KNodeChartPreview {
    var examples: some View {
        VStack {
            Text("Plots")
                .font(.largeTitle)
            map
            scatter
        }
    }

    var map: some View {
        VStack {
            Text("Map")
                .font(.headline)

            mapChart
                .background(Color.white)
                .kRadius(12.0)
                .padding(.horizontal, 12.0)
        }
    }

    var mapChart: some View {
        KAxisChart()
            .xAxis(SBAxisHelper.clearAxis())
            .yAxis(SBAxisHelper.clearAxis())
            .addBackground(KCustomBackground(
                source: .local(name: "map", bundle: nil),
                accessibilityIdentifier: "identifier"))
            .addNodes([
                .circle(
                    position: KShape.Position(center: CGPoint(x: 2.0, y: 2.0), xRadius: 0.6),
                    style: KShape.Style(fillColor: Color.orange.opacity(0.5), borderColor: Color.orange, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "CircleNode")),
                .circle(
                    position: KShape.Position(center: CGPoint(x: 3.0, y: 2.0), xRadius: 0.2),
                    style: KShape.Style(fillColor: Color.green.opacity(0.5), borderColor: Color.green, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "CricleNode")),
                .circle(
                    position: KShape.Position(center: CGPoint(x: 7.0, y: 5.0), xRadius: 0.8),
                    style: KShape.Style(fillColor: Color.red.opacity(0.7), borderColor: Color.red, borderWidth: 2.0),
                    accessibility: .decorative(identifier: "CircleNode2")),
                .star(
                    position: KShape.Position(center: CGPoint(x: 4.9, y: 5.8), xRadius: 0.4),
                    numberOfVertices: 5,
                    style: KShape.Style(fillColor: Color.yellow.opacity(0.2), borderColor: Color.black, borderWidth: 1.0),
                    accessibility: .decorative(identifier: "StarNode"))
            ])
            .frame(maxWidth: .infinity)
            .padding()
    }

    var scatter: some View {
        VStack {
            Text("Scatter")
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
            .frame(maxWidth: .infinity)
            .frame(height: 300.0)
            .padding()
            .background(Color.white)
            .kRadius(12.0)
            .padding(.horizontal, 12.0)
    }
}

// MARK: - KNodeChartSection Section
private struct KNodeChartSection: View {
    var title: String
    var xAxis: KAxis
    var yAxis: KAxis
    var nodes: [KNode]
    var height: CGFloat = 300.0

    @State private var showAlert = false
    @State var textAlert: String = ""

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)

            nodeChart
                .background(Color.white)
                .kRadius(12.0)
                .padding(.horizontal, 12.0)
        }
    }

    var nodeChart: some View {
        KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
            .addNodes(nodes)
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .padding()
    }
}

// MARK: - Preview
#if DEBUG
#Preview {
    KNodeChartPreview()
}
#endif
// swiftlint:disable:this file_length
