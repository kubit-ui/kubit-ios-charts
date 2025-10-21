public import Foundation

/// This extension provides segment for the component.
public extension KBar {
    /// It represents a segment of the bar.
    struct Segment: Equatable, Identifiable {
        /// Unique identifier for the segment. It conforms to the `Identifiable` protocol.
        public var id: String
        /// The value of the segment. It is expressed in the magnitude of the X-axis for horizontal bars
        /// or the Y-axis for vertical bars.
        public let value: CGFloat
        /// The style of the segment, which defines visual properties, such as color and corner radius.
        public let style: KBar.Segment.Style
        /// Accessibility information associated with the segment, such as identifiers and labels.
        var accessibility: KBar.Segment.Accessibility

        /// Segment initializer.
        /// - Parameters:
        ///   - identifier: string identifier of the segment.
        ///   - value: value of the segment expressed in the magnitude of X-axis for horizontal bars or Y-axis
        ///   for vertical bars.
        ///   - style: style of the segment. It is initialized to default values.
        ///   - accessibilityLabel: accessibility label of the segment.
        ///   - accessibilityValue: accessibility value of the segment.
        public init(identifier: String,
                    value: CGFloat,
                    style: KBar.Segment.Style = KBar.Segment.Style(),
                    accessibilityLabel: String,
                    accessibilityValue: String) {
            self.id = identifier
            self.value = value
            self.style = style
            self.accessibility = Accessibility(label: accessibilityLabel, value: accessibilityValue)
        }
    }
}

// MARK: - Accessibility
public extension KBar.Segment {
    /// Accessibility hint setter for ``KBar.Segment``.
    /// - Parameter hint: accessibility hint for the segment.
    /// - Returns: updated ``KBar.Segment``.
    func accessibilityHint(_ hint: String?) -> KBar.Segment {
        guard hint != accessibility.hint else {
            return self
        }
        var segment = self
        segment.accessibility.hint = hint
        return segment
    }
}
