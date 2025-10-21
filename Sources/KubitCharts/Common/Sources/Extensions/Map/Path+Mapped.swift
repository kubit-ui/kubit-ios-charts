import SwiftUI

/// This extension provides a mapper for the component.
extension Path {
    mutating func mapped(xAxis: KAxis, yAxis: KAxis, canvasSize: CGSize) {
        var elements: [Path.Element] = []
        self.forEach { element in
            switch element {
            case let .move(point):
                elements.append(.move(to: point.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize)))
            case let .line(point):
                elements.append(.line(to: point.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize)))
            case let .quadCurve(point, control):
                elements.append(.quadCurve(
                    to: point.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize),
                    control: control.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize)))
            case let .curve(point, control1, control2):
                elements.append(.curve(
                    to: point.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize),
                    control1: control1.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize),
                    control2: control2.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize)))
            case .closeSubpath:
                elements.append(.closeSubpath)
            }
        }

        self = Path()
        for element in elements {
            switch element {
            case let .move(point):
                self.move(to: point)
            case let .line(point):
                self.addLine(to: point)
            case let .quadCurve(point, control):
                self.addQuadCurve(to: point, control: control)
            case let .curve(point, control1, control2):
                self.addCurve(to: point, control1: control1, control2: control2)
            case .closeSubpath:
                self.closeSubpath()
            }
        }
    }
}
