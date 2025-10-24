
public extension KBar.LabelStyle {
    /// Position for the component's label.
    struct Position: Equatable {
        let type: PositionType

        enum PositionType {
            case topLeading
            case topTrailing
            case bottomLeading
            case bottomTrailing
            case top
            case bottom
        }

        /// `topLeading` position.
        public static var topLeading: Position {
            Position(type: .topLeading)
        }

        /// `topTrailing` position.
        public static var topTrailing: Position {
            Position(type: .topTrailing)
        }

        /// `bottomLeading` position.
        public static var bottomLeading: Position {
            Position(type: .bottomLeading)
        }

        /// `bottomTrailing` position.
        public static var bottomTrailing: Position {
            Position(type: .bottomTrailing)
        }

        /// `top` position.
        public static var top: Position {
            Position(type: .top)
        }

        /// `bottom` position.
        public static var bottom: Position {
            Position(type: .bottom)
        }
    }
}
