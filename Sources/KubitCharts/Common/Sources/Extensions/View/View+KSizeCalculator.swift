import Combine
import SwiftUI

struct KSizeCalculator: ViewModifier {
    @Binding var size: CGSize
    let makeAnimation: Bool

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
        if makeAnimation {
            withAnimation {
                size = proxy.size
            }
        } else {
            size = proxy.size
        }
    }
}

extension View {
    /// Method to save measurements of views.
    ///
    /// - Parameters:
    ///  - size: parameter to store the size of the view.
    ///  - makeAnimation: animation boolean to make animation. The default value is `true`.
    /// - Returns: a modifier with size of measured view.
    func saveSize(in size: Binding<CGSize>, makeAnimation: Bool = true) -> some View {
        modifier(KSizeCalculator(size: size, makeAnimation: makeAnimation))
    }
}
