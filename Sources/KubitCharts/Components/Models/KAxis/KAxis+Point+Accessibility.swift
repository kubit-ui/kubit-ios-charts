// swiftlint:disable:this file_name
import SwiftUI

/// This extension provides accessibility setup for the component.
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

        /// Axis Point Accessibility initializer.
        /// - Parameters:
        ///   - identifier: It is used as `accessibilityIdentifier` for the component.
        ///   - label: It is used as `accessibilityLabel` for the component. `nil` by default.
        ///   - value: It is used as `accessibilityValue` for the component. `nil` by default.
        ///   - hint: It is used as `accessibilityHint` for the component. `nil` by default.
        public init(identifier: String, label: String? = nil, value: String? = nil, hint: String? = nil) {
            self.identifier = identifier
            self.label = label
            self.value = value
            self.hint = hint
        }
    }
}
