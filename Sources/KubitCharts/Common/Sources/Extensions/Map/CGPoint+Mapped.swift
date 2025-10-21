import Foundation

/// This extension provides a mapper for the component.
extension CGPoint {
    func mapped(xAxis: KAxis, yAxis: KAxis, canvasSize: CGSize) -> CGPoint {
        CGPoint(
            x: x.mappedX(axis: xAxis, canvasWidth: canvasSize.width),
            y: y.mappedY(axis: yAxis, canvasHeight: canvasSize.height))
    }

    func zoomed(minX: CGFloat = 0,
                maxX: CGFloat = 0,
                minY: CGFloat = 0,
                maxY: CGFloat = 0,
                canvasSize: CGSize) -> CGPoint {
        CGPoint(
            x: x.mappedXZoomed(minX: minX, maxX: maxX, canvasWidth: canvasSize.width),
            y: y.mappedYZoomed(minY: minY, maxY: maxY, canvasHeight: canvasSize.height))
    }
}

/// This extension provides a mapper for the component.
extension CGFloat {
    func mappedX(axis: KAxis, canvasWidth: CGFloat) -> CGFloat {
        let realWidth = axis.realAxisWidth(canvasWidth: canvasWidth)
        return realWidth * (self - axis.minValue) / axis.fullRange
    }

    func mappedY(axis: KAxis, canvasHeight: CGFloat) -> CGFloat {
        let realHeight = axis.realAxisHeight(canvasHeight: canvasHeight)
        return realHeight * (axis.maxValue - self) / axis.fullRange + canvasHeight - realHeight
    }

    func mappedXZoomed(minX: CGFloat, maxX: CGFloat, canvasWidth: CGFloat) -> CGFloat {
        let normX = (self - minX) / (maxX - minX)
        let zoomedX = normX * canvasWidth
        return zoomedX
    }

    func mappedYZoomed(minY: CGFloat, maxY: CGFloat, canvasHeight: CGFloat) -> CGFloat {
        let normY = (self - minY) / (maxY - minY)
        let zoomedY = (1 - normY) * canvasHeight
        return zoomedY
    }
}
