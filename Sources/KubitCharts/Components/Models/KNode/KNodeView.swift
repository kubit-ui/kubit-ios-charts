import SwiftUI

struct KNodeView: View {
    var xAxis: KAxis
    var yAxis: KAxis
    var node: KNode
    var scrollOffset: CGSize

    var body: some View {
        ZStack {
            nodeView
            GeometryReader { geo in
                AccessibleNodeView(xAxis: xAxis, yAxis: yAxis, node: node, scrollOffset: scrollOffset, size: geo.size)
            }
        }
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
