public extension KPieChart {
    /// Accessibility information needed to make the component accessible and testable.
    struct Accessibility {
        /// It is used as `accessibilityIdentifier` for the component.
        var identifier: String
        /// It is used as `accessibilityLabel` for the component.
        var label: String?
        /// It is used as `accessibilityValue` for the component.
        var value: String?
        /// It is used as `accessibilityHint` for the component.
        var hint: String?

        /// It is used to know if the accessibility has been configured for this component.
        public var isAccessible: Bool {
            label != nil || value != nil || hint != nil
        }

        var iconIdentifier: String { "\(identifier)Icon" }
        var labelIdentifier: String { "\(identifier)Label" }
    }
}
