import SwiftUI

// swiftlint:disable function_parameter_count
extension GraphicsContext {
    func drawCircle(center: CGPoint,
                    radius: CGFloat,
                    fillColor: Color,
                    borderColor: Color,
                    borderWidth: CGFloat,
                    haloColor: Color?,
                    haloWidth: CGFloat,
                    size: CGSize) {
        drawCircularHalo(center: center, radius: radius, haloColor: haloColor, haloWidth: haloWidth, clearCircle: true)

        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: Angle(degrees: 360.0), clockwise: true)
        fill(path, with: .color(fillColor), style: FillStyle())
        stroke(path, with: .color(borderColor), style: StrokeStyle(lineWidth: borderWidth))
    }

    func drawSquare(center: CGPoint,
                    radius: CGFloat,
                    fillColor: Color,
                    borderColor: Color,
                    borderWidth: CGFloat,
                    haloColor: Color?,
                    haloWidth: CGFloat) {
        drawCircularHalo(center: center, radius: radius, haloColor: haloColor, haloWidth: haloWidth)

        let initialX = center.x - radius
        let finalX = center.x + radius
        let initialY = center.y - radius
        let finalY = center.y + radius
        var path = Path()
        path.move(to: CGPoint(x: initialX, y: initialY))
        path.addLine(to: CGPoint(x: initialX, y: finalY))
        path.addLine(to: CGPoint(x: finalX, y: finalY))
        path.addLine(to: CGPoint(x: finalX, y: initialY))
        path.closeSubpath()

        fill(path, with: .color(fillColor), style: FillStyle())
        stroke(path, with: .color(borderColor), style: StrokeStyle(lineWidth: borderWidth))
    }

    func drawStar(center: CGPoint,
                  radius: CGFloat,
                  numberOfVertices: Int,
                  fillColor: Color,
                  borderColor: Color,
                  borderWidth: CGFloat,
                  haloColor: Color?,
                  haloWidth: CGFloat) {
        drawCircularHalo(center: center, radius: radius, haloColor: haloColor, haloWidth: haloWidth)

        let anglePortion = 2 * .pi / Double(numberOfVertices)
        var path = Path()
        for index in 0..<numberOfVertices * 2 {
            let angle = Double(index) * anglePortion / 2
            let point = CGPoint(
                x: center.x + CGFloat(cos(angle)) * (index % 2 == 0 ? radius : radius / 2),
                y: center.y + CGFloat(sin(angle)) * (index % 2 == 0 ? radius : radius / 2))

            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }

        path.closeSubpath()
        fill(path, with: .color(fillColor), style: FillStyle())
        stroke(path, with: .color(borderColor), style: StrokeStyle(lineWidth: borderWidth))
    }

    func drawPolygon(center: CGPoint,
                     radius: CGFloat,
                     numberOfVertices: Int,
                     fillColor: Color,
                     borderColor: Color,
                     borderWidth: CGFloat,
                     haloColor: Color?,
                     haloWidth: CGFloat) {
        guard numberOfVertices >= 3 else {
            return
        }
        drawCircularHalo(center: center, radius: radius, haloColor: haloColor, haloWidth: haloWidth)

        let angle = 2 * .pi / CGFloat(numberOfVertices)
        let startAngle = -CGFloat.pi / 2

        var path = Path()
        for index in 0..<numberOfVertices {
            let xPosition = center.x + radius * cos(startAngle + angle * CGFloat(index))
            let yPosition = center.y + radius * sin(startAngle + angle * CGFloat(index))
            if index == 0 {
                path.move(to: CGPoint(x: xPosition, y: yPosition))
            } else {
                path.addLine(to: CGPoint(x: xPosition, y: yPosition))
            }
        }
        path.closeSubpath()
        fill(path, with: .color(fillColor), style: FillStyle())
        stroke(path, with: .color(borderColor), style: StrokeStyle(lineWidth: borderWidth))
    }

    func drawCross(center: CGPoint,
                   radius: CGFloat,
                   fillColor: Color,
                   borderColor: Color,
                   borderWidth: CGFloat,
                   haloColor: Color?,
                   haloWidth: CGFloat) {
        drawCircularHalo(center: center, radius: radius, haloColor: haloColor, haloWidth: haloWidth)

        var path = Path()
        path.move(to: CGPoint(x: center.x - radius, y: center.y))
        path.addLine(to: CGPoint(x: center.x + radius, y: center.y))
        path.move(to: CGPoint(x: center.x, y: center.y - radius))
        path.addLine(to: CGPoint(x: center.x, y: center.y + radius))
        fill(path, with: .color(fillColor), style: FillStyle())
        stroke(path, with: .color(borderColor), style: StrokeStyle(lineWidth: borderWidth))
    }

    func drawCircularHalo(center: CGPoint, radius: CGFloat, haloColor: Color?, haloWidth: CGFloat, clearCircle: Bool = false) {
        if let haloColor, haloWidth > .zero {
            var outerCirclePath = Path()
            outerCirclePath.addArc(
                center: center,
                radius: radius + haloWidth,
                startAngle: .degrees(0),
                endAngle: .degrees(360),
                clockwise: false)

            var innerCirclePath = Path()
            innerCirclePath.addArc(
                center: center,
                radius: radius,
                startAngle: .degrees(0),
                endAngle: .degrees(360),
                clockwise: false)
            fill(outerCirclePath, with: .color(haloColor))
            if clearCircle {
                fill(innerCirclePath, with: .color(.clear))
            }
        }
    }
}
// swiftlint:enable function_parameter_count
