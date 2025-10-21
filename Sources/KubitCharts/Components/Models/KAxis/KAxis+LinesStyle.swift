public import SwiftUI

/// This extension provides style for the component.
public extension KAxis {
    /// Struct with the styling of lines for the axis.
    struct LinesStyle: Equatable {
        /// The default width for all the lines inside the axis. This value can be overridden for each point.
        public let defaultWidth: CGFloat
        /// The default color for all the lines inside the axis. This value can be overridden for each point.
        public let defaultColor: Color
        /// The default dash pattern for all dashed lines inside the axis. This value can be overridden for each point.
        public let defaultDashPattern: [CGFloat]

        /// LabelsStyle initializer.
        /// - Parameters:
        ///   - defaultWidth: default width for all the lines inside axis. It can be overridden in each point. `1.0` by default.
        ///   - defaultColor: default color for all the lines inside axis. It can be overridden in each point. `.gray` by default.
        ///   - defaultDashPattern: default dash pattern for all dashed lines inside axis. It can be overridden in each point. `[4, 4]` by default.
        public init(defaultWidth: CGFloat = 1.0,
                    defaultColor: Color = .gray,
                    defaultDashPattern: [CGFloat] = [4, 4]) {
            self.defaultWidth = defaultWidth
            self.defaultColor = defaultColor
            self.defaultDashPattern = defaultDashPattern
        }
    }
}
