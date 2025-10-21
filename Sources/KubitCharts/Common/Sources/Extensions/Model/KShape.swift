public import SwiftUI

/// A geometric shape used for rendering complex vector paths.
public struct KShape: Equatable {
    let type: KShapeType

    enum KShapeType: Equatable {
        case circle(position: KShape.Position)
        case polygon(position: KShape.Position, numberOfVertices: Int)
        case star(position: KShape.Position, numberOfVertices: Int)
        case cross(position: KShape.Position)
        case custom(position: KShape.Position, path: Path)
    }

    /// Circular shape.
    /// - Parameter position: position of the shape expressed in the same magnitud of X-axis and Y-axis.
    public static func circle(position: KShape.Position) -> KShape {
        KShape(type: .circle(position: position))
    }

    /// Polygon shape.
    /// - Parameters:
    ///   - position: position of the shape expressed in the same magnitud of X-axis and Y-axis.
    ///   - numberOfVertices: number of vertices of the polygon.
    public static func polygon(position: KShape.Position, numberOfVertices: Int) -> KShape {
        KShape(type: .polygon(position: position, numberOfVertices: numberOfVertices))
    }

    /// Star shape.
    /// - Parameters:
    ///   - position: position of the shape expressed in the same magnitud of X-axis and Y-axis.
    ///   - numberOfVertices: number of vertices of the star.
    public static func star(position: KShape.Position, numberOfVertices: Int) -> KShape {
        KShape(type: .star(position: position, numberOfVertices: numberOfVertices))
    }

    /// Cross shape.
    /// - Parameters:
    ///   - position: position of the shape expressed in the same magnitud of X-axis and Y-axis.
    ///   - numberOfVertices: number of vertices of the polygon.
    public static func cross(position: KShape.Position) -> KShape {
        KShape(type: .cross(position: position))
    }

    /// Custom path shape.
    /// - Parameters:
    ///   - path: path used to build the node. Points of the Path should be in the same magnitude than chart axes.
    ///   - center: center of the shape expressed in the same magnitudes as X-axis and Y-axis.
    ///   - xRadius: radius of the shape expressed in the same magnitud of X-axis.
    ///   - haloWidth: width of the halo. `.zero` by default.
    public static func custom(path: Path, center: CGPoint, xRadius: CGFloat, haloWidth: CGFloat = .zero) -> KShape {
        KShape(type: .custom(position: KShape.Position(center: center, xRadius: xRadius, haloWidth: haloWidth), path: path))
    }
}

// MARK: - Internal
extension KShape {
    var position: KShape.Position? {
        switch type {
        case let .circle(position):
            position
        case let .polygon(position, _):
            position
        case let .star(position, _):
            position
        case let .cross(position):
            position
        case let .custom(position, _):
            position
        }
    }

    var unmappedCenter: CGPoint {
        position?.center ?? .zero
    }

    var unmappedXRadius: CGFloat {
        position?.xRadius ?? .zero
    }

    var rotation: Angle {
        position?.rotation ?? .zero
    }

    var unmappedHaloWidth: CGFloat {
        position?.haloWidth ?? .zero
    }
}
