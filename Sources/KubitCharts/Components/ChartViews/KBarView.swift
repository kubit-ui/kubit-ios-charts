import SwiftUI

struct KBarView: View {
    var xAxis: KAxis
    var yAxis: KAxis
    var bar: KBar
    var scrollOffset: CGSize

    var body: some View {
        barView
            .accessibilityLabel(bar.accessibility.label)
            .accessibilityChildren {
                accessibilityView
            }
    }
}

// MARK: - Inner Views
private extension KBarView {
    @ViewBuilder var barView: some View {
        switch bar.orientation {
        case .horizontal:
            horizontalBar
        default:
            verticalBar
        }
    }

    @ViewBuilder var horizontalBar: some View {
        if let label = bar.labelStyle.value {
            unrotatedLabel(label)
        }
        horizontalSegmentsBar
    }

    var horizontalSegmentsBar: some View {
        let segments = bar.segments
        return Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

            let widthPerUnit = xAxis.realAxisWidth(canvasWidth: size.width) / xAxis.fullRange
            let segmentPadding = bar.segmentsStyle.spacing / 2

            let initialX = bar.origin.x.mappedX(axis: xAxis, canvasWidth: size.width)
            let finalY = (bar.origin.y + bar.width / 2).mappedY(axis: yAxis, canvasHeight: size.height)
            let initialY = (bar.origin.y - bar.width / 2).mappedY(axis: yAxis, canvasHeight: size.height)

            var currentWidth: CGFloat = initialX
            for (index, segment) in segments.enumerated() {
                let corners = segment.style.corners
                let finalX: CGFloat
                if index == 0 || index == segments.count - 1 {
                    finalX = currentWidth + widthPerUnit * segment.value - segmentPadding
                } else {
                    finalX = currentWidth + widthPerUnit * segment.value - 2 * segmentPadding
                }

                var path = Path()
                if corners.topLeading > .zero {
                    let topLeading = corners.topLeading
                    path.move(to: CGPoint(x: currentWidth, y: finalY + topLeading))
                    path.addArc(
                        center: CGPoint(x: currentWidth + topLeading, y: finalY + topLeading),
                        radius: topLeading,
                        startAngle: .degrees(0.0),
                        endAngle: .degrees(270.0),
                        clockwise: false)
                } else {
                    path.move(to: CGPoint(x: currentWidth, y: finalY))
                }
                if corners.topTrailing > .zero {
                    let topTrailing = corners.topTrailing
                    path.addLine(to: CGPoint(
                        x: currentWidth + widthPerUnit * segment.value - topTrailing - segmentPadding,
                        y: finalY))
                    path.addArc(
                        center: CGPoint(
                            x: currentWidth + widthPerUnit * segment.value - segmentPadding - topTrailing,
                            y: finalY + topTrailing),
                        radius: topTrailing,
                        startAngle: .degrees(270.0),
                        endAngle: .degrees(360.0),
                        clockwise: false)
                } else {
                    path.addLine(to: CGPoint(x: currentWidth + widthPerUnit * segment.value - segmentPadding, y: finalY))
                }
                if corners.bottomTrailing > .zero {
                    let bottomTrailing = corners.bottomTrailing
                    path.addLine(to: CGPoint(
                        x: currentWidth + widthPerUnit * segment.value - segmentPadding,
                        y: initialY - bottomTrailing))
                    path.addArc(
                        center: CGPoint(
                            x: currentWidth + widthPerUnit * segment.value - bottomTrailing - segmentPadding,
                            y: initialY - bottomTrailing),
                        radius: bottomTrailing,
                        startAngle: .degrees(0.0),
                        endAngle: .degrees(90.0),
                        clockwise: false)
                } else {
                    path.addLine(to: CGPoint(x: currentWidth + widthPerUnit * segment.value - segmentPadding, y: initialY))
                }
                if corners.bottomLeading > .zero {
                    let bottomLeading = corners.bottomLeading
                    path.addLine(to: CGPoint(x: currentWidth + bottomLeading, y: initialY))
                    path.addArc(
                        center: CGPoint(x: currentWidth + bottomLeading, y: initialY - bottomLeading),
                        radius: bottomLeading,
                        startAngle: .degrees(90.0),
                        endAngle: .degrees(180.0),
                        clockwise: false)
                } else {
                    path.addLine(to: CGPoint(x: currentWidth, y: initialY))
                }

                path.closeSubpath()

                let color = segment.style.color ?? bar.segmentsStyle.defaultColor
                context.fill(path, with: .color(color), style: FillStyle())
                currentWidth = finalX + 2 * segmentPadding
            }
        }
    }

    @ViewBuilder var verticalBar: some View {
        if let label = bar.labelStyle.value {
            rotatedLabel(label)
        }
        verticalSegmentsBar
    }

    var verticalSegmentsBar: some View {
        let segments = bar.segments
        return Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

            let heightPerUnit = yAxis.realAxisHeight(canvasHeight: size.height) / yAxis.fullRange
            let segmentPadding = bar.segmentsStyle.spacing / 2

            let initialY = bar.origin.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size).y
            let initialX = (bar.origin.x - bar.width / 2).mappedX(axis: xAxis, canvasWidth: size.width)
            let finalX = (bar.origin.x + bar.width / 2).mappedX(axis: xAxis, canvasWidth: size.width)

            var currentHeight: CGFloat = initialY
            for (index, segment) in segments.enumerated() {
                let corners = segment.style.corners
                let finalY: CGFloat
                if index == 0 || index == segments.count - 1 {
                    finalY = currentHeight - heightPerUnit * segment.value + segmentPadding
                } else {
                    finalY = currentHeight - heightPerUnit * segment.value + 2 * segmentPadding
                }

                var path = Path()
                if corners.bottomLeading > .zero {
                    let bottomLeading = corners.bottomLeading
                    path.move(to: CGPoint(x: initialX + bottomLeading, y: currentHeight))
                    path.addArc(
                        center: CGPoint(x: initialX + bottomLeading, y: currentHeight - bottomLeading),
                        radius: bottomLeading,
                        startAngle: .degrees(90.0),
                        endAngle: .degrees(180.0),
                        clockwise: false)
                } else {
                    path.move(to: CGPoint(x: initialX, y: currentHeight))
                }
                if corners.topLeading > .zero {
                    let topLeading = corners.topLeading
                    path.addLine(to: CGPoint(x: initialX, y: finalY + topLeading))
                    path.addArc(
                        center: CGPoint(x: initialX + topLeading, y: finalY + topLeading),
                        radius: topLeading,
                        startAngle: .degrees(360.0),
                        endAngle: .degrees(270.0),
                        clockwise: false)
                } else {
                    path.addLine(to: CGPoint(x: initialX, y: finalY))
                }
                if corners.topTrailing > .zero {
                    let topTrailing = corners.topTrailing
                    path.addLine(to: CGPoint(x: finalX - topTrailing, y: finalY))
                    path.addArc(
                        center: CGPoint(x: finalX - topTrailing, y: finalY + topTrailing),
                        radius: topTrailing,
                        startAngle: .degrees(270.0),
                        endAngle: .degrees(360.0),
                        clockwise: false)
                } else {
                    path.addLine(to: CGPoint(x: finalX, y: finalY))
                }
                if corners.bottomTrailing > .zero {
                    let bottomTrailing = corners.bottomTrailing
                    path.addLine(to: CGPoint(x: finalX, y: currentHeight + bottomTrailing))
                    path.addArc(
                        center: CGPoint(x: finalX - bottomTrailing, y: currentHeight - bottomTrailing),
                        radius: bottomTrailing,
                        startAngle: .degrees(0.0),
                        endAngle: .degrees(90.0),
                        clockwise: false)
                } else {
                    path.addLine(to: CGPoint(x: finalX, y: currentHeight))
                }

                path.closeSubpath()

                let color = segment.style.color ?? bar.segmentsStyle.defaultColor
                context.fill(path, with: .color(color), style: FillStyle())
                currentHeight = finalY - 2 * segmentPadding
            }
        }
    }

    @ViewBuilder
    func label(_ positions: [KBar.LabelStyle.Position], rotated: Bool = false) -> some View {
        if let label = bar.labelStyle.value, positions.contains(bar.labelStyle.position) {
            if rotated {
                rotatedLabel(label)
            } else {
                unrotatedLabel(label)
            }
        }
    }

    func rotatedLabel(_ label: String) -> some View {
        Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

            let lineSpacing = bar.labelStyle.lineSpacing
            let result = computeAnchorAndLabelPoint(size: size)
            let anchor: UnitPoint = result.anchor
            var point: CGPoint = result.labelPoint
            if bar.labelStyle.position == .top {
                point = CGPoint(x: point.x, y: point.y - lineSpacing * CGFloat(label.count))
            }

            let startY: CGFloat = point.y + bar.labelStyle.lineSpacing / 2

            for (index, character) in label.enumerated() {
                let characterText = Text(String(character))
                    .font(bar.labelStyle.font)
                    .foregroundColor(bar.labelStyle.color)
                let position = CGPoint(x: point.x, y: startY + CGFloat(index) * lineSpacing)
                context.draw(characterText, at: position, anchor: anchor)
            }
        }
    }

    func unrotatedLabel(_ label: String) -> some View {
        Canvas { context, size in
            context.translateBy(x: scrollOffset.width, y: scrollOffset.height)

            let result = computeAnchorAndLabelPoint(size: size)
            let anchor: UnitPoint = result.anchor
            let point: CGPoint = result.labelPoint

            context.draw(
                Text(label)
                    .font(bar.labelStyle.font)
                    .foregroundColor(bar.labelStyle.color),
                at: point,
                anchor: anchor)
        }
    }

    func computeAnchorAndLabelPoint(size: CGSize) -> (anchor: UnitPoint, labelPoint: CGPoint) {
        let anchor: UnitPoint
        let point: CGPoint
        switch bar.labelStyle.position.type {
        case .topLeading:
            anchor = UnitPoint.bottomLeading
            let initialX = bar.origin.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size).x
            let finalY = (bar.origin.x + bar.width / 2).mappedY(axis: yAxis, canvasHeight: size.height)
            point = CGPoint(x: initialX, y: finalY - bar.labelStyle.barSpacing)
        case .top:
            anchor = UnitPoint.bottom
            if bar.orientation == .horizontal {
                let initialX = bar.origin.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size).x
                let finalX = (bar.origin.x + bar.sumOfValues).mappedX(axis: xAxis, canvasWidth: size.width)
                let finalY = (bar.origin.x + bar.width / 2).mappedY(axis: yAxis, canvasHeight: size.height)
                point = CGPoint(x: initialX + (finalX - initialX) / 2, y: finalY - bar.labelStyle.barSpacing)
            } else {
                let centerX = bar.origin.x.mappedX(axis: xAxis, canvasWidth: size.width)
                let finalY = (bar.origin.y + bar.sumOfValues).mappedY(axis: yAxis, canvasHeight: size.height)
                point = CGPoint(x: centerX, y: finalY + bar.labelStyle.barSpacing)
            }
        case .topTrailing:
            anchor = UnitPoint.bottomTrailing
            let finalX = (bar.origin.x + bar.sumOfValues).mappedX(axis: xAxis, canvasWidth: size.width)
            let finalY = (bar.origin.x + bar.width / 2).mappedY(axis: yAxis, canvasHeight: size.height)
            point = CGPoint(x: finalX, y: finalY - bar.labelStyle.barSpacing)
        case .bottomLeading:
            anchor = UnitPoint.topLeading
            let initialX = bar.origin.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size).x
            let initialY = (bar.origin.x - bar.width / 2).mappedY(axis: yAxis, canvasHeight: size.height)
            point = CGPoint(x: initialX, y: initialY + bar.labelStyle.barSpacing)
        case .bottom:
            anchor = UnitPoint.top
            if bar.orientation == .horizontal {
                let initialX = bar.origin.mapped(xAxis: xAxis, yAxis: yAxis, canvasSize: size).x
                let finalX = (bar.origin.x + bar.sumOfValues).mappedX(axis: xAxis, canvasWidth: size.width)
                let initialY = (bar.origin.x - bar.width / 2).mappedY(axis: yAxis, canvasHeight: size.height)
                point = CGPoint(x: initialX + (finalX - initialX) / 2, y: initialY + bar.labelStyle.barSpacing)
            } else {
                let centerX = bar.origin.x.mappedX(axis: xAxis, canvasWidth: size.width)
                let initialY = bar.origin.y.mappedY(axis: yAxis, canvasHeight: size.height)
                point = CGPoint(x: centerX, y: initialY + bar.labelStyle.barSpacing)
            }
        case .bottomTrailing:
            anchor = UnitPoint.topTrailing
            let finalX = (bar.origin.x + bar.sumOfValues).mappedX(axis: xAxis, canvasWidth: size.width)
            let initialY = (bar.origin.x - bar.width / 2).mappedY(axis: yAxis, canvasHeight: size.height)
            point = CGPoint(x: finalX, y: initialY + bar.labelStyle.barSpacing)
        }
        return (anchor, point)
    }
}

// MARK: - Accessibility
private extension KBarView {
    var accessibilityView: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                let rects = bar.segmentRects(scrollOffset: scrollOffset, xAxis: xAxis, yAxis: yAxis, canvasSize: proxy.size)
                ForEach(bar.segments.indices, id: \.self) { index in
                    let segment = bar.segments[index]
                    Rectangle()
                        .frame(width: rects[segment.id]?.width, height: rects[segment.id]?.height)
                        .offset(x: rects[segment.id]?.minX ?? 0, y: rects[segment.id]?.minY ?? 0)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel(segment.accessibility.label)
                        .accessibilityValue(segment.accessibility.value)
                        .accessibilityHint(segment.accessibility.hint ?? "")
                        .accessibilitySortPriority(Double(bar.segments.count - index))
                }
            }
        }
    }
}

#if DEBUG
private struct KAxisChartBarPreview: View {
    var xAxis: KAxis {
        KAxis(
            behavior: .fill,
            points: [
                KAxis.Point(-5),
                KAxis.Point(-4, labelStyle: .labeled("-4"), lineStyle: .dashed()),
                KAxis.Point(-3, labelStyle: .labeled("-3"), lineStyle: .dashed()),
                KAxis.Point(-2, labelStyle: .labeled("-2"), lineStyle: .dashed()),
                KAxis.Point(-1, labelStyle: .labeled("-1"), lineStyle: .dashed()),
                KAxis.Point(0, labelStyle: .labeled("0", color: .black), lineStyle: .solid(width: 2.0, color: .black)),
                KAxis.Point(1, labelStyle: .labeled("1"), lineStyle: .dashed()),
                KAxis.Point(2, labelStyle: .labeled("2"), lineStyle: .dashed()),
                KAxis.Point(3, labelStyle: .labeled("3"), lineStyle: .dashed()),
                KAxis.Point(4, labelStyle: .labeled("4"), lineStyle: .dashed()),
                KAxis.Point(5)],
            labelsStyle: KAxis.LabelsStyle(position: .start))
    }

    var yAxis: KAxis {
        KAxis(
            behavior: .fill,
            points: [
                KAxis.Point(-5),
                KAxis.Point(-4, labelStyle: .labeled("-4"), lineStyle: .dashed()),
                KAxis.Point(-3, labelStyle: .labeled("-3"), lineStyle: .dashed()),
                KAxis.Point(-2, labelStyle: .labeled("-2"), lineStyle: .dashed()),
                KAxis.Point(-1, labelStyle: .labeled("-1"), lineStyle: .dashed()),
                KAxis.Point(0, labelStyle: .labeled("0", color: .black), lineStyle: .solid(width: 2.0, color: .black)),
                KAxis.Point(1, labelStyle: .labeled("1"), lineStyle: .dashed()),
                KAxis.Point(2, labelStyle: .labeled("2"), lineStyle: .dashed()),
                KAxis.Point(3, labelStyle: .labeled("3"), lineStyle: .dashed()),
                KAxis.Point(4, labelStyle: .labeled("4"), lineStyle: .dashed()),
                KAxis.Point(5)],
            labelsStyle: KAxis.LabelsStyle(position: .end))
    }

    var verticalBar: KBar {
        .vertical(
            origin: 1,
            width: 0.5,
            segments: [
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 1.0,
                    style: KBar.Segment.Style(color: .black, corners: .square),
                    accessibilityLabel: "Acc label for bar 1 segment 1",
                    accessibilityValue: "1 point"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 1.0,
                    style: KBar.Segment.Style(color: .brown, corners: .square),
                    accessibilityLabel: "Acc label for bar 1 segment 2",
                    accessibilityValue: "1 point"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 0.5,
                    style: KBar.Segment.Style(color: .green, corners: .square),
                    accessibilityLabel: "Acc label for bar 1 segmnet 3",
                    accessibilityValue: "0.5 points"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 0.5,
                    style: KBar.Segment.Style(color: .yellow, corners: .square),
                    accessibilityLabel: "Acc label for bar 1 segmnet 4",
                    accessibilityValue: "0.5 points"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 0.5,
                    style: KBar.Segment.Style(color: .yellow, corners: .square),
                    accessibilityLabel: "Acc label for bar 1 segmnet 5",
                    accessibilityValue: "0.5 points"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 0.5,
                    style: KBar.Segment.Style(color: .yellow, corners: .topRoundedOnly()),
                    accessibilityLabel: "Acc label for bar 1 segmnet 6",
                    accessibilityValue: "0.5 points")
            ],
            yOffset: .zero,
            segmentsStyle: KBar.SegmentsStyle(),
            labelStyle: KBar.LabelStyle("Patata", color: .black, position: .bottom),
            accessibilityIdentifier: "Bar1",
            accessibilityLabel: "Bar 1")
    }

    var horizontalBar: KBar {
        .horizontal(
            origin: .zero,
            height: 0.25,
            segments: [
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 1.0,
                    style: KBar.Segment.Style(color: .black, corners: .square),
                    accessibilityLabel: "Acc label for bar 2 segmnet 1",
                    accessibilityValue: "1 point"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 1.0,
                    style: KBar.Segment.Style(color: .brown, corners: .square),
                    accessibilityLabel: "Acc label for bar 2 segmnet 2",
                    accessibilityValue: "1 point"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 0.5,
                    style: KBar.Segment.Style(color: .green, corners: .square),
                    accessibilityLabel: "Acc label for bar 2 segmnet 3",
                    accessibilityValue: "0.5 points"),
                KBar.Segment(
                    identifier: UUID().uuidString,
                    value: 0.5,
                    style: KBar.Segment.Style(color: .yellow, corners: .trailingRoundedOnly()),
                    accessibilityLabel: "Acc label for bar 2 segmnet 4",
                    accessibilityValue: "0.5 points")
            ],
            xOffset: .zero,
            segmentsStyle: KBar.SegmentsStyle(),
            labelStyle: KBar.LabelStyle("Patata", color: .black, position: .top),
            accessibilityIdentifier: "Bar2",
            accessibilityLabel: "Bar 2")
    }

    var body: some View {
        KAxisChart()
            .xAxis(xAxis)
            .yAxis(yAxis)
            .addNegativeShadeRegions(color: Color.pink.opacity(0.5))
            .addBar(verticalBar)
            .addBar(horizontalBar)
            .padding(16.0)
    }
}

#Preview {
    KAxisChartBarPreview()
}
#endif
// swiftlint:disable:this file_length
