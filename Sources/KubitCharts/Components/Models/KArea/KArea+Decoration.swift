public extension KArea {
    /// Decoration for KArea.
    struct Decoration: Equatable {
        let type: DecorationType

        enum DecorationType: Equatable {
            case none
            case background(_ background: KArea.Decoration.Background)
        }

        /// No decoration for KArea.
        public static var none: Decoration {
            Decoration(type: .none)
        }

        /// Background decoration.
        /// - Parameter background: background decoration for KArea.
        public static func background(_ background: KArea.Decoration.Background) -> Decoration {
            Decoration(type: .background(background))
        }
    }
}
