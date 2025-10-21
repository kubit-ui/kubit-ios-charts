import KubitCharts
import SwiftUI

// Common logic for storybook previews.
struct SBAxisHelper {}

// MARK: - Axis
extension SBAxisHelper {
    static func clearAxis(_ range: ClosedRange<CGFloat> = 0...10) -> KAxis {
        KAxisBuilder()
            .addPointWithClearLine(range.lowerBound)
            .addPointWithClearLine(range.upperBound)
            .setLabelsViewPosition(.none)
            .build()
    }

    static func noLinesAxis(position: KAxis.LabelsStyle.Position, label0: String, label: String) -> KAxis {
        var builder = KAxisBuilder()
        for index in 0..<10 {
            builder = builder
                .addPointWithClearLine(CGFloat(index), labelStyle: .labeled(index == 0 ? label0 : label))
        }
        return builder
            .addPointWithClearLine(10.0)
            .setLabelsViewPosition(position)
            .build()
    }

    static func noLabelsAxis(position: KAxis.LabelsStyle.Position) -> KAxis {
        var builder = KAxisBuilder()
        for index in 0..<10 {
            builder = builder
                .addPoint(
                    CGFloat(index),
                    lineStyle: index == 0 ? .solid(width: 2.0, color: .originLineColor) : .dashed())
        }
        return builder
            .addPointWithClearLine(10.0)
            .setLabelsViewPosition(position)
            .build()
    }

    static func defaultAxis(position: KAxis.LabelsStyle.Position,
                            label0: String,
                            label: String,
                            addClearLineAtTheEnd: Bool = false,
                            slanted: Bool = false) -> KAxis {
        var builder = KAxisBuilder()
            .setLabelsViewPosition(position)
        for index in 0..<10 {
            let labelStyle: KAxis.Point.LabelStyle
            if slanted {
                labelStyle = index == 0 ? .rotated(label0, color: .black) : .rotated(label, color: .labelColor)
            } else {
                labelStyle = index == 0 ? .labeled(label0, color: .black) : .labeled(label, color: .labelColor)
            }

            builder = builder
                .addPoint(
                    CGFloat(index),
                    labelStyle: labelStyle,
                    lineStyle: index == 0 ? .solid(width: 2.0, color: .originLineColor) : .dashed(color: .lineColor))
        }
        if addClearLineAtTheEnd {
            builder = builder
                .addPointWithClearLine(10.0)
        }
        return builder.build()
    }

    static func negativeAxis(position: KAxis.LabelsStyle.Position, label0: String, label: String) -> KAxis {
        var builder = KAxisBuilder()
            .setLabelsViewPosition(position)
            .addPointWithClearLine(-10.0)
        for index in -9..<0 {
            builder = builder
                .addPoint(CGFloat(index), labelStyle: .labeled(label, color: .labelColor), lineStyle: .dashed(color: .lineColor))
        }
        return builder
            .addPoint(.zero,
                      labelStyle: .labeled(label0, color: .labelColor),
                      lineStyle: .solid(width: 2.0, color: .originLineColor))
            .build()
    }

    static func mixedAxis(position: KAxis.LabelsStyle.Position,
                          label0: String,
                          label: String,
                          addClearLineAtTheEnd: Bool = false) -> KAxis {
        var builder = KAxisBuilder()
            .addPointWithClearLine(-6.0)
            .addPoint(.zero, labelStyle: .labeled(label0, color: .black), lineStyle: .solid(width: 2.0, color: .originLineColor))
            .addPointWithClearLine(6.0)
            .setLabelsViewPosition(position)
        for index in -5..<6 {
            guard index != 0 else {
                continue
            }

            builder = builder
                .addPoint(
                    CGFloat(index),
                    labelStyle: .labeled("\(index < 0 ? "-" : "")\(label)", color: .labelColor),
                    lineStyle: .dashed(color: .lineColor))
        }
        return builder.build()
    }

    static func complexAxis(position: KAxis.LabelsStyle.Position, label0: String, label: String) -> KAxis {
        var builder = KAxisBuilder()
            .addPointWithClearLine(-6.0)
            .addPointWithClearLine(6.0)
            .setLabelsViewPosition(position)
            .addPoint(.zero, labelStyle: .labeled(label0, color: .black), lineStyle: .solid(width: 2.0, color: .originLineColor))
        for index in -5..<6 {
            guard index != 0 else {
                continue
            }
            builder = builder
                .addPoint(
                    CGFloat(index),
                    labelStyle: .labeled("\(index < 0 ? "-" : "")\(label)", color: .labelColor),
                    lineStyle: .dashed(color: .lineColor))
        }
        return builder.build()
    }

    static func minimumAxis(position: KAxis.LabelsStyle.Position, label0: String, label: String) -> KAxis {
        KAxisBuilder()
            .addPoint(.zero, labelStyle: .labeled(label0, color: .black), lineStyle: .solid(width: 2.0, color: .originLineColor))
            .addPoint(9.0, labelStyle: .labeled(label, color: .labelColor), lineStyle: .dashed(color: .lineColor))
            .addPointWithClearLine(10.0)
            .setLabelsViewPosition(position)
            .build()
    }

    static func scrollableAxis(label0: String, label: String, offset: CGFloat) -> KAxis {
        var builder = KAxisBuilder()
            .setAxisBehavior(.scrollable(pointsSpacing: 75.0, centerValue: .zero))
            .addPoint(.zero, labelStyle: .labeled(label0, color: .black), lineStyle: .solid(width: 2.0, color: .originLineColor))
            .addPointWithClearLine(-10.0)
            .addPointWithClearLine(10.0)
            .setLabelsViewPosition(.custom(scaledValue: 0.5, offset: offset))
        for index in -9..<10 {
            guard index != 0 else {
                continue
            }
            builder = builder
                .addPoint(
                    CGFloat(index),
                    labelStyle: .labeled("\(index < 0 ? "-" : "")\(label)", color: .labelColor),
                    lineStyle: .dashed(color: .lineColor))
        }
        return builder.build()
    }
}

// MARK: - Line points
extension SBAxisHelper {
    static func exponentialPoints(_ initialY: CGFloat = 3, factor: CGFloat = 10.0) -> [CGPoint] {
        var points = [CGPoint]()

        let numberOfPoints = 10
        for index in 0...numberOfPoints {
            let xPosition = CGFloat(index)
            let yPosition = initialY + 0.8 * exp(xPosition / factor)
            points.append(CGPoint(x: xPosition, y: yPosition))
        }
        return points
    }
}
