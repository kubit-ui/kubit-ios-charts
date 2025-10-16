/// This extension provides accessibility utilities for KNode.
/// Use this extension to expose meaningful accesibility information.
public extension KNode {
    /// Accessibility for KNode.
    struct Accessibility: Equatable {
        var identifier: String
        var label: String?
        var value: String?
        var hint: String?
        var isButton = false

        /// It is used to know if the accessibility has been configured for this component.
        public var isAccessible: Bool {
            label != nil || value != nil || hint != nil
        }

        /// Accessibility for decorative nodes (no interaction).
        /// - Parameter identifier: accessibility identifier for the node.
        public static func decorative(identifier: String) -> Accessibility {
            Accessibility(identifier: identifier)
        }

        /// Accessibility for interactuable nodes (buttons).
        /// - Parameters:
        ///   - identifier: accessibility identifier for the node.
        public static func interactuable(identifier: String) -> Accessibility {
            Accessibility(identifier: identifier, isButton: true)
        }
    }
}

// MARK: - Accessibility
public extension KNode {
    /// Accessibility label setter for  ``KNode``.
    /// - Parameter label: accessibility label for the component.
    /// - Returns: updated ``KNode``.
    func accessibilityLabel(_ label: String?) -> KNode {
        guard label != accessibility.label else {
            return self
        }
        var node = self
        node.accessibility.label = label
        return node
    }

    /// Accessibility label setter for  ``KNode``.
    /// - Parameter value: accessibility value for the component.
    /// - Returns: updated ``KNode``.
    func accessibilityValue(_ value: String?) -> KNode {
        guard value != accessibility.value else {
            return self
        }
        var node = self
        node.accessibility.value = value
        return node
    }

    /// Accessibility label setter for  ``KNode``.
    /// - Parameter hint: accessibility hint for the component.
    /// - Returns: updated ``KNode``.
    func accessibilityHint(_ hint: String?) -> KNode {
        guard hint != accessibility.hint else {
            return self
        }
        var node = self
        node.accessibility.hint = hint
        return node
    }
}
