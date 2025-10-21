public import SwiftUI

/// Struct used to shade a region of axis chart. It applies color on values mapped using `origin`
/// and `end` to build a rectangle. For example, if `origin` is equal to `CGPoint.zero` and
/// `end` is equal to `CGPoint(x: 100.0, y: 100.0)`, `color` will be applied to rectangle
/// built from [origin, CGPoint(origin.x, end.y), end, CGPoint(end.y, origin.x)].
public struct KShadeRegion: Equatable {
    /// The color for the shaded region.
    public let origin: CGPoint
    /// The ending point of the shaded region.
    public let end: CGPoint
    /// The starting point of the shaded region.
    public let color: Color

    /// Shade region data initializer.
    /// - Parameters:
    ///   - origin: the starting point of the shaded region.
    ///   - end: the ending point of the shaded region.
    ///   - color: the color applied to the shaded region.
    public init(origin: CGPoint, end: CGPoint, color: Color) {
        self.origin = origin
        self.end = end
        self.color = color
    }
}
