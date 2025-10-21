import SwiftUI

@MainActor
struct ComponentGroup: Identifiable {
    let id: String
    let name: String
    let components: [Component]

    init(name: String, components: [Component]) {
        self.id = name
        self.name = name
        self.components = components
    }

    static let groups: [ComponentGroup] = [
        ComponentGroup(name: "data visualization", components: [
            Component(name: "AxisChart") { KAxisChartPreview() },
            Component(name: "BarChart") { KBarChartPreview() },
            Component(name: "CustomBackgroundChart") { KCustomBackgroundChartPreview() },
            Component(name: "IntersectLine") { KIntersectLinePreview() },
            Component(name: "LegendChart") { KLegendChartPreview() },
            Component(name: "LineChart") { KLineChartPreview() },
            Component(name: "NodeChart") { KNodeChartPreview() },
            Component(name: "PieChart") { KPieChartPreview() },
            Component(name: "ZoomAreaChart") { KZoomAreaChartPreview() }
        ])
    ]
}
