public import Foundation

public extension KAxis {
    /// It controls the behavior of the axis.
    struct Behavior: Equatable {
        let type: BehaviorType

        enum BehaviorType: Equatable {
            case scrollable(pointsSpacing: CGFloat, centerValue: CGFloat?)
            case fill
        }

        /// It fills the behavior for the axis. The axis occupies the full width (for X-axis) or height (for Y-axis) of its parent container.
        public static var fill: Behavior {
            Behavior(type: .fill)
        }

        /// Scrollable behavior.
        /// - Parameters:
        ///    - pointsSpacing: it matches the width between units in X-axis and the height
        ///     between units in Y-axis. For example, if there is an X-axis with 1.000 points and scrollable behavior
        ///     with `pointsSpacing` equal to 30, the X-axis will have a total width of 1.000 \* 30 = 30.000 points.
        ///    - centerValue: value that is placed in the center. If X-axis is going to display values between
        ///     -1000 and 1000 and you set .zero as center value for both axes, you will see (0,0) in the center of the chart.
        ///     The default value is `nil`.
        /// - Returns: scrollable axis.
        public static func scrollable(pointsSpacing: CGFloat, centerValue: CGFloat? = nil) -> Behavior {
            Behavior(type: .scrollable(pointsSpacing: pointsSpacing, centerValue: centerValue))
        }
    }
}
