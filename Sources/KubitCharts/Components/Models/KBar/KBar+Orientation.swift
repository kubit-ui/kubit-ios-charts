/// This extension provides orientation for the component.
public extension KBar {
    /// Bar chart orientation.
    struct Orientation: Equatable {
        let type: OrientationType

        enum OrientationType {
            case horizontal
            case vertical
        }

        /// Horizontal bar.
        public static var horizontal: Orientation {
            Orientation(type: .horizontal)
        }

        /// Vertical bar.
        public static var vertical: Orientation {
            Orientation(type: .vertical)
        }
    }
}
