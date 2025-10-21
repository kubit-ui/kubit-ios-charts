// swiftlint:disable:this file_name

extension KBar.Segment {
    /// Accessibility information for the segment.
    struct Accessibility: Equatable {
        let label: String
        let value: String
        var hint: String?
    }
}
