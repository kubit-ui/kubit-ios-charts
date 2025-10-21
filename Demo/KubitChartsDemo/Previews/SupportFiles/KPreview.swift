import SwiftUI

struct KPreview<Content: View>: View {
    var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            Divider()
            content
                .padding(.vertical, 8)
        }
    }
}
