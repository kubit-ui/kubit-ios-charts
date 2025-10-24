public import Foundation

/// This extension represents different orientations for the component.
public extension KLegend {
    /// It represents different orientations for the component.
    struct Orientation {
        let type: OrientationType

        enum OrientationType: Equatable {
            case horizontal(spacing: CGFloat)
            case vertical
        }

        /// Horizontal orientation.
        /// - Parameter spacing: spacing between title and values views. `16.0` by default.
        public static func horizontal(spacing: CGFloat = 16.0) -> Orientation {
            Orientation(type: .horizontal(spacing: spacing))
        }

        /// Vertical orientation.
        public static var vertical: Orientation {
            Orientation(type: .vertical)
        }
    }
}
