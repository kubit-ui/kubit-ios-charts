/// This extension provides accessibility utilities for KShape.
/// Use this extension to expose meaningful accesibility information.
public extension KShape {
    /// Accessibility for Shape.
    struct Accessibility: Equatable {
        var identifier: String
        var label: String?
        var value: String?
        var hint: String?
        var isButton = false

        /// Accessibility for decorative nodes (no interaction).
        /// - Parameter identifier: accessibility identifier for the node.
        public static func decorative(identifier: String) -> Accessibility {
            Accessibility(identifier: identifier)
        }

        /// Accessibility for interactuable nodes (buttons).
        /// - Parameters:
        ///   - identifier: accessibility identifier for the node.
        ///   - label: accessibility label for the node.
        ///   - value: accessibility value for the node.
        ///   - hint: accessibility hint for the node. `nil` by default.
        public static func interactuable(identifier: String, label: String, value: String, hint: String? = nil) -> Accessibility {
            Accessibility(identifier: identifier, label: label, value: value, hint: hint, isButton: true)
        }
    }
}
