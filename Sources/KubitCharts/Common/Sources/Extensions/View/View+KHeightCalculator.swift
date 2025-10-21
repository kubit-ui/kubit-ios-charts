import Combine
import SwiftUI

/// A view modifier to get the maximum size of a view inside a forEach.
///
/// Usage example:
/// ```
/// @State var maxTabSize: CGSize = .zero
///
/// ForEach(tabs) { tab in
///    tab
///     .saveMaxHeight($maxTabSize)
/// }
/// ```
///
/// - Parameter size: binding to save the size.
///
struct KHeightCalculator: ViewModifier {
    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content.background(GeometryReader { proxy in
            Color.clear
                .onAppear {
                    size = proxy.size
                }
                .onReceive(Just(proxy), perform: { proxy in
                    updateSize(proxy)
                })
        })
    }

    private func updateSize(_ proxy: GeometryProxy) {
        withAnimation {
            if proxy.size.height > size.height {
                size = CGSize(width: size.width, height: proxy.size.height)
            }
            if proxy.size.width > size.width {
                size = CGSize(width: proxy.size.width, height: size.height)
            }
        }
    }
}

extension View {
    /// Method to save measurements of views, and get the max size inside a forEach.
    /// - Parameter size: parameter to store the size of the view.
    /// - Returns: a modifier with size of measured view.
    func saveMaxSize(in size: Binding<CGSize>) -> some View {
        modifier(KHeightCalculator(size: size))
    }
}
