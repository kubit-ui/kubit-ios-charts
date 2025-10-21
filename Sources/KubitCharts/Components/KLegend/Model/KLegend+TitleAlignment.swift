/// This extension represents different visual styles for the component.
public extension KLegend {
    /// It represents different visual styles for the component.
    struct TitleAlignment {
        let type: VariantType

        enum VariantType {
            case start
            case end
        }

        /// Left aligned.
        public static var start: TitleAlignment {
            TitleAlignment(type: .start)
        }

        /// Right aligned.
        public static var end: TitleAlignment {
            TitleAlignment(type: .end)
        }
    }
}
