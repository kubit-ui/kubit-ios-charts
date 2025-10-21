import SwiftUI

struct KNodeView: View {
    var xAxis: KAxis
    var yAxis: KAxis
    var node: KNode
    var scrollOffset: CGSize

    var body: some View {
        nodeView
    }
}

// MARK: - Inner Views
private extension KNodeView {
    var nodeView: some View {
        Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

            let mappedZero = CGFloat.zero.mappedX(axis: xAxis, canvasWidth: size.width)
            let mappedCenter = node.shape.unmappedCenter.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size)
            context.translateBy(x: mappedCenter.x, y: mappedCenter.y)
            context.rotate(by: node.shape.rotation)
            context.translateBy(x: -mappedCenter.x, y: -mappedCenter.y)

            let mappedRadius = node.shape.unmappedXRadius.mappedX(axis: xAxis, canvasWidth: size.width)
            let mappedHaloWidth = node.shape.unmappedHaloWidth.mappedX(axis: xAxis, canvasWidth: size.width)

            switch shape.type {
            case .circle:
                context.drawCircle(
                    center: mappedCenter,
                    radius: mappedRadius - mappedZero,
                    fillColor: node.style.fillColor,
                    borderColor: node.style.borderColor,
                    borderWidth: node.style.borderWidth,
                    haloColor: node.style.haloColor,
                    haloWidth: mappedHaloWidth - mappedZero,
                    size: size)
            case let .star(_, numberOfVertices):
                context.drawStar(
                    center: mappedCenter,
                    radius: mappedRadius - mappedZero,
                    numberOfVertices: numberOfVertices,
                    fillColor: node.style.fillColor,
                    borderColor: node.style.borderColor,
                    borderWidth: node.style.borderWidth,
                    haloColor: node.style.haloColor,
                    haloWidth: mappedHaloWidth - mappedZero)
            case let .polygon(_, numberOfVertices):
                context.drawPolygon(
                    center: mappedCenter,
                    radius: mappedRadius - mappedZero,
                    numberOfVertices: numberOfVertices,
                    fillColor: node.style.fillColor,
                    borderColor: node.style.borderColor,
                    borderWidth: node.style.borderWidth,
                    haloColor: node.style.haloColor,
                    haloWidth: mappedHaloWidth - mappedZero)
            case let .custom(_, path):
                var mappedPath = path
                mappedPath.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size)
                context.fill(mappedPath, with: .color(node.style.fillColor), style: FillStyle())
                context.stroke(
                    mappedPath,
                    with: .color(node.style.borderColor),
                    style: StrokeStyle(lineWidth: node.style.borderWidth))
                context.drawCircularHalo(
                    center: mappedCenter,
                    radius: mappedRadius - mappedZero,
                    haloColor: node.style.haloColor,
                    haloWidth: mappedHaloWidth - mappedZero)
            case .cross:
                context.drawCross(
                    center: mappedCenter,
                    radius: mappedRadius - mappedZero,
                    fillColor: node.style.fillColor,
                    borderColor: node.style.borderColor,
                    borderWidth: node.style.borderWidth,
                    haloColor: node.style.haloColor,
                    haloWidth: mappedHaloWidth - mappedZero)
            }
        }
    }
}

// MARK: - Shortcuts
private extension KNodeView {
    var shape: KShape {
        node.shape
    }
}

#if DEBUG
struct KNodePreview: View {
    var xAxis: KAxis {
        KAxis(
            behavior: .fill,
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
            behavior: .fill,
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

    var body: some View {
        KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
            .addNode(.circle(
                position: KShape.Position(center: .zero, xRadius: 0.8),
                style: KShape.Style(fillColor: Color.green.opacity(0.3), borderColor: Color.green, borderWidth: 2.0),
                accessibility: .decorative(identifier: "CircleNode")))
            .addNode(.polygon(
                position: KShape.Position(center: CGPoint(x: 2.0, y: 2.0), xRadius: 0.4),
                numberOfVertices: 4,
                style: KShape.Style(fillColor: Color.red.opacity(0.3), borderColor: Color.red, borderWidth: 2.0),
                accessibility: .decorative(identifier: "PolygonNode")))
            .addNode(.star(
                position: KShape.Position(center: CGPoint(x: -2.0, y: 2.0), xRadius: 0.6),
                numberOfVertices: 5,
                style: KShape.Style(fillColor: Color.yellow.opacity(0.3), borderColor: Color.orange, borderWidth: 2.0),
                accessibility: .decorative(identifier: "StarNode")))
            .addNode(.polygon(
                position: KShape.Position(center: CGPoint(x: -2.0, y: -2.0), xRadius: 0.6, rotation: Angle(degrees: 120)),
                numberOfVertices: 3,
                style: KShape.Style(fillColor: Color.blue.opacity(0.3), borderColor: Color.blue, borderWidth: 2.0),
                accessibility: .decorative(identifier: "PolygonNode")))
            .addNode(.polygon(
                position: KShape.Position(center: CGPoint(x: 2.0, y: -2.0), xRadius: 0.6, rotation: Angle(degrees: 120)),
                numberOfVertices: 5,
                style: KShape.Style(fillColor: Color.black.opacity(0.3), borderColor: Color.black, borderWidth: 2.0),
                accessibility: .decorative(identifier: "PolygonNode2")))
    }
}

#Preview {
    KNodePreview()
}
#endif
