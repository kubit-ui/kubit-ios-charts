public import SwiftUI

/// A modifier that applies radius and border to a view.
struct KRadius: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    var padding: CGFloat

    /// It applies the modifier to the view.
    func body(content: Content) -> some View {
        content
            .clipShape(KCornerRadiusShape(radius: radius, corners: corners, padding: padding))
    }
}

/// Struct to apply radius to corners.
struct KCornerRadiusShape: InsettableShape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    var inset = 0.0
    var padding = 0.0

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(rect: rect, cornerRadius: radius, corners: corners, padding: padding)
        return Path(path.cgPath)
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var cornerRadius = self
        cornerRadius.inset += amount
        return cornerRadius
    }
}

extension UIBezierPath {
    /// It creates a rounded rectangle using `UIBezierPath`with 1/3 of the rect.width or height to avoid a bug in the standard
    /// `UIBezierPath(roundedRect:cornerRadius)`.
    ///
    /// However it clamps, the corner radius to a maximum of half of the width or height of the rect in order to avoid incorrect drawing.
    ///
    /// - Parameters:
    ///   - rect: rectangle that defines the basic shape of the path
    ///   - cornerRadius: radius of each corner oval. A value of 0 results in a rectangle without rounded corners.
    ///   - corners: corners we want to be rounded.
    ///   - padding: radius padding to be added into the drawn shape. The default value is `.zero`.
    convenience init(rect: CGRect, cornerRadius: CGFloat, corners: UIRectCorner, padding: CGFloat = .zero) {
        self.init()

        let cornerRadius = min(cornerRadius, rect.width / 2, rect.height / 2)
        let topLeftRadius = corners == .allCorners || corners.contains(.topLeft) ? cornerRadius : .zero
        let topRightRadius = corners == .allCorners || corners.contains(.topRight) ? cornerRadius : .zero
        let bottomLeftRadius = corners == .allCorners || corners.contains(.bottomLeft) ? cornerRadius : .zero
        let bottomRightRadius = corners == .allCorners || corners.contains(.bottomRight) ? cornerRadius : .zero

        let path = self
        path.move(to: CGPoint(x: padding + topLeftRadius, y: padding))
        path.addLine(to: CGPoint(x: rect.width - topRightRadius - padding, y: padding))
        path.addArc(
            withCenter: CGPoint(x: rect.width - topRightRadius - padding, y: topRightRadius + padding),
            radius: topRightRadius,
            startAngle: 3 * .pi / 2,
            endAngle: .zero,
            clockwise: true)
        path.addLine(to: CGPoint(x: rect.width - padding, y: rect.height - bottomRightRadius - padding))
        path.addArc(
            withCenter: CGPoint(
                x: rect.width - bottomRightRadius - padding,
                y: rect.height - bottomRightRadius - padding),
            radius: bottomRightRadius,
            startAngle: .zero,
            endAngle: .pi / 2,
            clockwise: true)
        path.addLine(to: CGPoint(x: padding + bottomLeftRadius, y: rect.height - padding))
        path.addArc(
            withCenter: CGPoint(x: padding + bottomLeftRadius, y: rect.height - bottomLeftRadius - padding),
            radius: bottomLeftRadius,
            startAngle: .pi / 2,
            endAngle: .pi,
            clockwise: true)
        path.addLine(to: CGPoint(x: padding, y: topLeftRadius + padding))
        path.addArc(
            withCenter: CGPoint(x: padding + topLeftRadius, y: topLeftRadius + padding),
            radius: topLeftRadius,
            startAngle: .pi,
            endAngle: 3 * .pi / 2,
            clockwise: true)
        path.close()
    }
}

public extension View {
    /// It applies a corner radius to the current view. It also draws a border if `borderColor` and `borderWidth` are provided.
    /// - Parameters:
    ///   - radius: the corner radius to apply. It can be relative or absolute.
    ///   - corners: the corners to be rounded.  `.allCorners`  by default.
    ///   - padding: the radius padding to be added into the drawn shape. `.zero` by default.
    /// - Returns: a modified view with the specified corner radius and optional border.
    func kRadius(_ radius: CGFloat, corners: UIRectCorner = UIRectCorner.allCorners, padding: CGFloat = .zero) -> some View {
        modifier(KRadius(radius: radius, corners: corners, padding: padding))
    }
}
