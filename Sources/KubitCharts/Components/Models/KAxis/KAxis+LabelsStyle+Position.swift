// swiftlint:disable:this file_name
public import Foundation

/// This extension provides style for the component.
public extension KAxis.LabelsStyle {
    /// It controls the position of the labels column for Y-axis or the labels file for X-axis.
    struct Position: Equatable {
        let type: PositionType

        enum PositionType: Equatable {
            case start
            case end
            case none
            case custom(scaledValue: CGFloat, offset: CGFloat)
        }

        /// No labels are displayed.
        public static var none: Position {
            Position(type: .none)
        }

        /// Labels column or file are displayed at the start (top for X-axis and leading for Y-axis).
        public static var start: Position {
            Position(type: .start)
        }

        /// Labels column or file are displayed at the end (bottom for X-axis and trailing for Y-axis).
        public static var end: Position {
            Position(type: .end)
        }

        /// Labels column or file are displayed in defined position.
        /// - Parameters:
        ///   - scaledValue: value that should be defined in the range of `[0, 1]`. `0` displays the labels column or file
        ///   at the start and `1` displays the labels view at the end. For example, `0.5` would display labels in the middle. This
        ///   point could be visible or not, it depends on the behavior of the axis.
        ///   - offset: it provides a way to move labels from its predefined position. Positive offsets move
        ///   labels to the right (for X-axis) or bottom (Y-axis).
        public static func custom(scaledValue: CGFloat, offset: CGFloat) -> Position {
            Position(type: .custom(scaledValue: scaledValue, offset: offset))
        }
    }
}
