public import SwiftUI

/// #  KNode
///
/// A node is a point that represents a specific data value. It visually marks the position of the data on the chart, helping to interpret and analyze the information. It is also interactive, showing the data when the user taps or hovers over it.
///
/// ## How to use it:
/// ```
/// let nodes = ([
///     .polygon(
///         position: KShape.Position(center: CGPoint(x: 2.0, y: 2.0), xRadius: 0.2),
///         numberOfVertices: 4,
///         style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
///         accessibility: .decorative(identifier: "Square1")),
///     .polygon(
///         position: KShape.Position(center: CGPoint(x: 1.0, y: 2.0), xRadius: 0.2),
///         numberOfVertices: 4,
///         style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
///         accessibility: .decorative(identifier: "Square2"))
/// ])
/// KAxisChart()
///     .xAxis(xAxis)
///     .yAxis(yAxis)
///     .addNodes(nodes)
/// ```
public struct KNode: Equatable {
    /// The shape of the node. It is represented by a `KShape`.
    public let shape: KShape
    /// The style of the shape. It is defined using `KShape.Style`.
    public let style: KShape.Style
    /// Accessibility information associated with the shape, such as identifiers and labels.
    public let accessibility: KShape.Accessibility

    /// It creates a circular node.
    /// - Parameters:
    ///   - position: the position of the circle. It is defined using `KShape.Position`. It specifies
    ///     the center and radius of the circle in the coordinate space of the chart.
    ///   - style: ``KShape.Style`` of the node.
    ///   - accessibility: accessibility information associated with the node, such as identifiers and labels.
    /// -  Returns: a ``KNode`` with a circular shape.
    public static func circle(position: KShape.Position, style: KShape.Style, accessibility: KShape.Accessibility) -> KNode {
        KNode(shape: .circle(position: position), style: style, accessibility: accessibility)
    }

    /// It creates a star-shaped node.
    /// - Parameters:
    ///   - position: the position of the star. It is defined using `KShape.Position`. It specifies
    ///     the center and size of the star in the coordinate space of the chart.
    ///   - numberOfVertices:  the number of vertices (points) of the star. `5` by default.
    ///   - style: ``KShape.Style`` of the node.
    ///   - accessibility: accessibility information associated with the node, such as identifiers and labels.
    /// -  Returns: a ``KNode`` with a star shape.
    public static func star(position: KShape.Position,
                            numberOfVertices: Int = 5,
                            style: KShape.Style,
                            accessibility: KShape.Accessibility) -> KNode {
        KNode(shape: .star(position: position, numberOfVertices: numberOfVertices), style: style, accessibility: accessibility)
    }

    /// It creates a polygon-shaped node.
    /// - Parameters:
    ///   - position: the position of the polygon.
    ///   - numberOfVertices: the number of vertices of the polygon. It must be at least three (triangle).
    ///   - style: ``KShape.Style`` of the node.
    ///   - accessibility: accessibility information associated with the node, such as identifiers and labels.
    /// -  Returns: a polygon-shaped ``KNode``.
    public static func polygon(position: KShape.Position,
                               numberOfVertices: Int,
                               style: KShape.Style,
                               accessibility: KShape.Accessibility) -> KNode {
        KNode(shape: .polygon(position: position, numberOfVertices: numberOfVertices), style: style, accessibility: accessibility)
    }

    /// It creates a cross-shaped node.
    /// - Parameters:
    ///   - position: the position of the cross. It is defined using `KShape.Position`. It specifies
    ///     the center and size of the cross in the coordinate space of the chart.
    ///   - style: style of the node.
    ///   - accessibility: accessibility information associated with the node, such as identifiers and labels.
    /// -  Returns: a cross-shaped``KNode``.
    public static func cross(position: KShape.Position, style: KShape.Style, accessibility: KShape.Accessibility) -> KNode {
        KNode(shape: .cross(position: position), style: style, accessibility: accessibility)
    }

    /// It creates a custom path-shaped node.
    /// - Parameters:
    ///   - path: a `Path` instance used to build the shape of the node. The points of the path
    ///     should be expressed in the same magnitudes as the chart's axes.
    ///   - center: the center point of the shape. It is expressed in the same coordinate space as the
    ///     chart's X and Y axes.
    ///   - xRadius: the horizontal radius of the shape, which determines the scaling along the X-axis.
    ///   - style: ``KShape.Style`` of the node.
    ///   - accessibility: accessibility information associated with the node, such as identifiers and labels.
    /// -  Returns: a ``KNode`` with a custom patch shape.
    public static func custom(path: Path,
                              center: CGPoint,
                              xRadius: CGFloat,
                              style: KShape.Style,
                              accessibility: KShape.Accessibility) -> KNode {
        KNode(shape: .custom(path: path, center: center, xRadius: xRadius), style: style, accessibility: accessibility)
    }

    /// Equatable conformance.
    public static func == (lhs: KNode, rhs: KNode) -> Bool {
        lhs.shape == rhs.shape && lhs.style == rhs.style && lhs.accessibility == rhs.accessibility
    }
}

// MARK: - KubitChartModelContract
extension KNode: KubitChartModelContract {
    func processTap(location: CGPoint, scrollOffset: CGSize, xAxis: KAxis, yAxis: KAxis, canvasSize: CGSize) -> Bool {
        let mappedZero = CGFloat.zero.mappedX(axis: xAxis, canvasWidth: canvasSize.width)
        let mappedCenter = shape.unmappedCenter.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: canvasSize)
        let mappedRadius = shape.unmappedXRadius.mappedX(axis: xAxis, canvasWidth: canvasSize.width) - mappedZero
        let mappedRect = CGRect(
            origin: CGPoint(x: mappedCenter.x - mappedRadius, y: mappedCenter.y - mappedRadius),
            size: CGSize(width: 2 * mappedRadius, height: 2 * mappedRadius))
        return mappedRect.contains(location)
    }
}
