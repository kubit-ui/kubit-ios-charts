/// This extension provides accessibility for the component.
public extension KLine {
    /// Line appearance.
    struct Appearance: Equatable {
        let type: AppearanceType

        enum AppearanceType {
            case rounded
            case square
        }

        /// `Rounded` type of line.
        public static var rounded: Appearance {
            Appearance(type: .rounded)
        }

        /// `Square` type of line.
        public static var square: Appearance {
            Appearance(type: .square)
        }
    }
}
