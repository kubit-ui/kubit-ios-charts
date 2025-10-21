import SwiftUI

/// This extension provides a helper for the component.
extension View {
    /// It applies a conditional transformation to the View
    ///
    /// * If condition is `true`, it applies the transformation to the given view (`self`).
    /// * If condition is `false`, then `self` is returned so other modifiers can be chained.
    ///
    /// Usage example:
    /// ```swift
    /// view.if(highlighted) { view in
    ///     view.background(Color.accent)
    /// }
    /// ```
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// It applies a conditional transformation to the view.
    ///
    /// * If condition is `true`, it applies the transformation to the given view (`self`).
    /// * If condition is `false`,  then `self` is returned so other modifiers can be chained.
    ///
    /// Usage example:
    /// ```swift
    /// view.if(highlighted) { view in
    ///     view.background(Color.accent)
    /// }
    /// ```
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Binding<Bool>, transform: (Self) -> Transform) -> some View {
        if condition.wrappedValue {
            transform(self)
        } else {
            self
        }
    }
}
