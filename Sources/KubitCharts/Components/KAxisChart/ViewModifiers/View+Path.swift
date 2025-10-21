import SwiftUI

struct PathView: ViewModifier {
    let points: [CGPoint]
    let strokeStyle: StrokeStyle
    let linePointAppearance: KLine.Appearance
    let color: Color
    let shadowColor: Color?

    private let constants = Constants()

    func body(content: Content) -> some View {
        ZStack {
            content

            GeometryReader { geometry in
                let path = Path.pathBuilder(
                    points: pointMapper(points),
                    linePointAppearance: linePointAppearance,
                    in: geometry.size)

                path
                    .stroke(style: strokeStyle)
                    .foregroundColor(color)
                    .shadow(color: isShadowColorEnabled, radius: constants.radius, x: constants.xValue, y: constants.yValue)
            }
        }
    }
}

// MARK: - Constants
/// These values should be removed once this library is stabilized.
private extension PathView {
    struct Constants {
        let radius: CGFloat = 4
        let xValue: CGFloat = 2
        let yValue: CGFloat = 2
    }
}

// MARK: - Mapper
private extension PathView {
    func pointMapper(_ points: [CGPoint]) -> [CGPoint] {
        points.map { CGPoint(x: $0.x, y: $0.y) }
    }
}

// MARK: - Shortcuts
private extension PathView {
    var isShadowColorEnabled: Color {
        guard let shadowColor = shadowColor else {
            return .clear
        }

        return shadowColor
    }
}

extension View {
    /// Method to create a specific path.
    /// - Parameters:
    ///  - points: points to be shown on the component.
    ///  - strokeStyle: stroke style of the line.
    ///  - linePointAppearance: line point appearance to be shown on the component.
    ///  - color: color of the line.
    ///  - shadowColor: shadow color of the line. `nil` by default.
    /// - Returns: a modified color path.
    func pathBuilder(points: [CGPoint],
                     strokeStyle: StrokeStyle,
                     linePointAppearance: KLine.Appearance,
                     color: Color,
                     shadowColor: Color? = nil) -> some View {
        self.modifier(PathView(
            points: points,
            strokeStyle: strokeStyle,
            linePointAppearance: linePointAppearance,
            color: color,
            shadowColor: shadowColor))
    }
}
