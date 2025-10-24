import SwiftUI

/// This extension provides line setup for the component.
extension KAxis {
    struct LineData: Equatable {
        let origin: CGPoint
        let end: CGPoint

        func xLabelPoint(axis: KAxis,
                         customPosition: CGFloat?,
                         startPadding: CGFloat,
                         endPadding: CGFloat,
                         size: CGSize) -> CGPoint {
            var positionX = origin.x
            if axis.behavior.type == .fill {
                let startPaddingOffset = -startPadding / size.width * origin.x + startPadding
                let endPaddingOffset = endPadding / size.width * origin.x
                positionX += startPaddingOffset - endPaddingOffset
            }
            if let customPosition {
                return CGPoint(x: positionX, y: customPosition)
            }
            let originY = axis.labelsStyle.position == .end ? .zero : size.height
            let spacingBetweenLabelsAndChart = axis.labelsStyle.spacingBetweenLabelsAndChart
            let offset = axis.labelsStyle.position == .start ? -spacingBetweenLabelsAndChart : spacingBetweenLabelsAndChart
            let positionY = originY + offset
            return CGPoint(x: positionX, y: positionY)
        }

        func yLabelPoint(axis: KAxis,
                         customPosition: CGFloat?,
                         startPadding: CGFloat,
                         endPadding: CGFloat,
                         size: CGSize) -> CGPoint {
            var positionY = origin.y
            if axis.behavior.type == .fill {
                let startPaddingOffset = -startPadding / size.height * origin.y + startPadding
                let endPaddingOffset = endPadding / size.height * origin.y
                positionY += startPaddingOffset - endPaddingOffset
            }
            if let customPosition {
                return CGPoint(x: customPosition, y: positionY)
            }
            let originX = axis.labelsStyle.position == .start ? size.width : .zero
            let spacingBetweenLabelsAndChart = axis.labelsStyle.spacingBetweenLabelsAndChart
            let offset = axis.labelsStyle.position == .start ? -spacingBetweenLabelsAndChart : spacingBetweenLabelsAndChart
            let positionX = originX + offset
            return CGPoint(x: positionX, y: positionY)
        }
    }
}
