extension KPieChart {
    /// Configuration of the component.
    struct Configuration {
        /// Array of segments for the chart.
        var segments: [Segment]
        /// Icon to be shown on the component.
        var icon: KImageResource?
        /// Label to be shown on the chart.
        var label: String?
    }
}
