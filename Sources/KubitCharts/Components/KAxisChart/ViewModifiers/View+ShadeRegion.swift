import SwiftUI

private struct ShadeRegion: ViewModifier {
    var regions: [KShadeRegion]
    var xAxis: KAxis
    var yAxis: KAxis
    var paddings: KAxisChart.InnerPaddings
    var scrollOffset: CGSize

    func body(content: Content) -> some View {
        ZStack {
            Canvas { context, size in
                context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

                for region in regions {
                    let origin = region.origin.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size)
                    let end = region.end.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size)

                    var path = Path()
                    path.move(to: origin)
                    path.addLine(to: CGPoint(x: origin.x, y: end.y))
                    path.addLine(to: CGPoint(x: end.x, y: end.y))
                    path.addLine(to: CGPoint(x: end.x, y: origin.y))
                    path.addLine(to: origin)
                    context.fill(path, with: .color(region.color))
                }
            }
            .padding(.leading, paddings.leading)
            .padding(.trailing, paddings.trailing)
            .padding(.top, paddings.top)
            .padding(.bottom, paddings.bottom)

            content
        }
    }
}

extension View {
    func shade(regions: [KShadeRegion],
               xAxis: KAxis,
               yAxis: KAxis,
               paddings: KAxisChart.InnerPaddings,
               scrollOffset: CGSize) -> some View {
        modifier(ShadeRegion(regions: regions, xAxis: xAxis, yAxis: yAxis, paddings: paddings, scrollOffset: scrollOffset))
    }
}
