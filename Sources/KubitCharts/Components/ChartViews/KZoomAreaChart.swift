public import SwiftUI

/// #  KZoomAreaChart
/// This interactive thumbnail usually follows a graph and represents the same period as the chart. It allows users to zoom in on a more specific period of time within the graph for a more detailed view.
/// [Figma design]
/// (figma.com/design/XJnmdNlhMwmyx4QpGGpIN3/-R.8--Kubit-Global-Documentation?node-id=107594-45887&t=cwA2HXdQsEyXfhbG-4)
///
/// ## How to use it:
/// ```
///
/// var zoomLine: KLine {
///   let points: [CGPoint] = [
///    CGPoint.zero,
///    CGPoint(x: 1.0, y: 1)]
///
///     return KLine(
///         points: points,
///         appearance: .rounded,
///         style: .solid,
///         zoomable: KLine.Zoomable(startHandle: lowerBound, endHandle: upperBound, points: points),
///         accessibilityIdentifier: "zoomlineIdentifier")
/// }
///
/// NOTE: It is really important to declare KLine as ZOOMABLE in order to pass handles as parameters.
///
/// var previewChart: some View {
///     KAxisChart()
///         .xAxis(xAxis)
///         .yAxis(yAxis)
///         .addLines([zoomLine])
/// }
///
///
/// KZoomAreaChart(
///     startHandle: $startHandle,
///     endHandle: $endHandle,
///     content: { previewChart },
///     opacityColor: Color.blue)
/// ```
public struct KZoomAreaChart<Content: View>: View {
    @Binding private var startHandle: Double
    @Binding private var endHandle: Double

    @State private var isSetRange: Bool = false

    private let content: () -> Content
    private var opacityColor: Color

    /// It initializes and configures the component, making it ready for use.
    /// - Parameters:
    ///   - startHandle: the handle displayed at the start of the graph.
    ///   - endHandle: the handle displayed at the end of the graph.
    ///   - content: content of the graph.
    ///   - opacityColor: the color of the area between the handles.
    public init(startHandle: Binding<Double>,
                endHandle: Binding<Double>,
                content: @escaping () -> Content,
                opacityColor: Color) {
        self._startHandle = startHandle
        self._endHandle = endHandle
        self.content = content
        self.opacityColor = opacityColor
    }

    public var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height

            let lowerX = CGFloat(startHandle) * width
            let upperX = CGFloat(endHandle) * width
            let rangeWidth = upperX - lowerX

            ZStack {
                content()

                if isSetRange {
                    rangeAreaView(width: rangeWidth, height: height, lowerX: lowerX, upperX: upperX)
                }

                // Leading handle view.
                contentHandleView
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = Double((lowerX + value.translation.width) / width)
                                startHandle = min(max(Constants.minValue, newValue), endHandle - Constants.minSpacing)
                                isSetRange = true
                            })
                    .position(x: lowerX, y: height / 2)

                // Trailing handle view.
                contentHandleView
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = Double((upperX + value.translation.width) / width)
                                endHandle = max(min(Constants.maxValue, newValue), startHandle + Constants.minSpacing)
                                isSetRange = true
                            })
                    .position(x: upperX, y: height / 2)
            }
        }
    }
}

// MARK: - Views
private extension KZoomAreaChart {
    var contentHandleView: some View {
        ZStack {
            lineView
            handleView
        }
    }

    var lineView: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(width: Constants.handleVerticalLineWidth)
    }

    var handleView: some View {
        ZStack {
            Circle()
                .frame(width: Constants.handleSize, height: Constants.handleSize)
                .foregroundColor(Color.white)
                .contentShape(Rectangle())
                .overlay(
                    Circle()
                        .stroke(Color.gray, lineWidth: Constants.handleLineWidth)
                        .frame(width: Constants.handleSize, height: Constants.handleSize))

            let handleIcon = KImage.LocalResource(name: "icon_ds_handle-2", bundle: .module)
            KImage(resource: handleIcon)
                .tintColor(.gray)
                .accessibilityIdentifier("handleIconIdentifier")
        }
    }

    func rangeAreaView(width: CGFloat, height: CGFloat, lowerX: CGFloat, upperX: CGFloat) -> some View {
        Rectangle()
            .fill(opacityColor.opacity(0.15))
            .frame(width: width, height: height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let delta = (value.translation.width * Constants.sensivity) / width
                        let range = endHandle - startHandle
                        var newLower = startHandle + delta
                        var newUpper = endHandle + delta

                        if newLower < Constants.minValue {
                            newLower = Constants.minValue
                            newUpper = newLower + range
                        } else if newUpper > Constants.maxValue {
                            newUpper = Constants.maxValue
                            newLower = newUpper - range
                        }

                        startHandle = newLower
                        endHandle = newUpper
                    })
            .position(x: (lowerX + upperX) / 2, y: height / 2)
    }
}

// MARK: - Constants
private struct Constants {
    static let minValue: Double = 0.0
    static let maxValue: Double = 1.0
    static let minSpacing: Double = 0.2
    static let handleSize: CGFloat = 34
    static let handleLineWidth: CGFloat = 1
    static let handleVerticalLineWidth: CGFloat = 2
    static let sensivity: CGFloat = 0.1
}
