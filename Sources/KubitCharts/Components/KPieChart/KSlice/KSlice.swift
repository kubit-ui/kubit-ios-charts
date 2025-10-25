import SwiftUI

/// View that represents slice implementation.
struct KSlice: View {
    struct SliceData {
        var startAngle: Angle
        var endAngle: Angle
        var segment: KPieChart.Segment
    }

    @Binding var chartSize: CGFloat?
    var sliceData: SliceData
    let angle = Angle(degrees: -90)
    var startAngle: Angle {
        angle + sliceData.startAngle
    }
    var endAngle: Angle {
        angle + sliceData.endAngle
    }

    var body: some View {
        GeometryReader { geometry in
            let width: CGFloat = min(geometry.size.width, geometry.size.height)
            let height = width
            let center = CGPoint(x: width * 0.5, y: height * 0.5)
            let radius = width * 0.5
            let segment = sliceData.segment
            ZStack {
                Path { path in
                    path.move(to: center)
                    path.addArc(
                        center: center,
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: false)
                }
                .fill(segment.color)
            }
            .onAppear {
                chartSize = width
            }
            .accessibilityIdentifier(segment.accessibility.identifier ?? "")
            .accessibilityHidden(!segment.accessibility.isAccessible)
            .accessibilityLabel(segment.accessibility.label ?? "")
            .accessibilityValue(segment.accessibility.value ?? "")
            .accessibilityHint(segment.accessibility.hint ?? "")
        }
    }
}
