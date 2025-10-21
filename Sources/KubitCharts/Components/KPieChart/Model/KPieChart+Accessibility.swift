extension KPieChart {
    /// Accessibility information needed to make the component accessible and testable.
    struct Accessibility {
        /// It is used as `accessibilityIdentifier` for the component.
        var identifier: String
        /// It is used as `accessibilityLabel` for the component.
        var label: String?

        var iconIdentifier: String { "\(identifier)Icon" }
        var labelIdentifier: String { "\(identifier)Label" }
    }
}
