// swiftlint:disable:this file_name
import SwiftUI

/// This extension provides Accessibility setup for the component.
public extension KAxis.Point {
    /// Accessibility information needed to make the component accessible and testable.
    struct Accessibility: Equatable {
        /// It is used as `accessibilityIdentifier` for the component.
        public var identifier: String
        /// It is used as `accessibilityLabel` for the component.
        public var label: String?
        /// It is used as `accessibilityValue` for the component.
        public var value: String?
        /// It is used as `accessibilityHint` for the component.
        public var hint: String?

        /// It is used to know if the accessibility has been configured for this component.
        public var isAccessible: Bool {
            label != nil || value != nil || hint != nil
        }
    }
}
