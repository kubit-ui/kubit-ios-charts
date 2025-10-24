
/// This extension provides style for the component.
public extension KLine.Style {
    /// Decoration for the model.
    struct Decoration: Equatable {
        let type: DecorationType

        enum DecorationType: Equatable {
            case none
            case shadow(_ shadow: KLine.Style.Shadow)
            case background(_ background: KLine.Style.Background)
        }

        /// No decoration for the line.
        public static var none: Decoration {
            Decoration(type: .none)
        }

        /// Shadow decoration.
        /// - Parameter shadow: shadow decoration for line.
        public static func shadow(_ shadow: KLine.Style.Shadow) -> Decoration {
            Decoration(type: .shadow(shadow))
        }

        /// Background decoration.
        /// - Parameter background: background decoration for line.
        public static func background(_ background: KLine.Style.Background) -> Decoration {
            Decoration(type: .background(background))
        }
    }
}
