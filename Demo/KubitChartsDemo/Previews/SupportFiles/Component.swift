import SwiftUI

@MainActor
struct Component: Identifiable {
    let id: String
    let name: String
    let view: any View

    init(name: String, @ViewBuilder view: () -> some View) {
        self.id = name
        self.name = name
        self.view = view()
    }
}
