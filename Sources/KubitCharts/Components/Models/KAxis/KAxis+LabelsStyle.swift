public import SwiftUI

/// This extension provides style for the component.
public extension KAxis {
    /// Struct with the styling of labels view.
    struct LabelsStyle: Equatable {
        /// Minimum size for the labels view inside the axis.
        public let minSize: CGSize
        /// Position of the labels view (for example, `.start`, `.end`, or `.none`).
        public var position: Position
        /// Spacing between labels and the chart. It influences the padding based on the axis orientation.
        public let spacingBetweenLabelsAndChart: CGFloat
        /// Default font applied to all labels in the axis.
        public let defaultFont: Font
        /// Default color applied to all labels in the axis.
        public let defaultColor: Color
        /// Default rotation for all the rotated labels inside axis.
        public let defaultRotation: Angle

        /// LabelsStyle initializer.
        /// - Parameters:
        ///   - minSize: minimum size for labels view inside an axis. `CGSize(width: 24.0, height: 24.0)` by default.
        ///   - position: position of labels view inside the chart. `.none` by default.
        ///   - spacingBetweenLabelsAndChart: space between labels and chart. Depending on `position`,
        ///   this property translates into padding over one edge or other. For example, for Y-axis and `.start` position,
        ///   this spacing property will be used as trailingPadding. For X-axis and `.end` position, it will be used as
        ///   top padding. `8.0` by default.
        ///   - defaultFont: default font for all the labels inside axis. It can be overridden in each point.
        ///   `.system(size: 12, weight: .regular)` by default.
        ///   - defaultColor: default color for all the labels inside axis. It can be overridden in each point.
        ///    `.gray` by default.
        ///   - defaultRotation: default rotation for all the rotated labels inside axis. It can be overridden in each point.
        ///   `.degrees(30.0)` by default
        public init(minSize: CGSize = CGSize(width: 24.0, height: 24.0),
                    position: Position = .none,
                    spacingBetweenLabelsAndChart: CGFloat = 8.0,
                    defaultFont: Font = .system(size: 12, weight: .regular),
                    defaultColor: Color = .gray,
                    defaultRotation: Angle = .degrees(30.0)) {
            self.minSize = minSize
            self.position = position
            self.spacingBetweenLabelsAndChart = spacingBetweenLabelsAndChart
            self.defaultFont = defaultFont
            self.defaultColor = defaultColor
            self.defaultRotation = defaultRotation
        }
    }
}
