import SwiftUI

struct KCustomBackgroundView: View {
    var xAxis: KAxis
    var yAxis: KAxis
    var background: KCustomBackground
    var scrollOffset: CGSize
    @Binding var height: CGFloat?

    var body: some View {
        image
    }

    @ViewBuilder var image: some View {
        switch background.source.type {
        case let .local(name, bundle):
            Image(name, bundle: bundle)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .accessibilityIdentifier(background.accessibility.identifier)
                .background(GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            height = proxy.size.height
                        }
                })
        case let .remote(url):
            AsyncImage(url: url) { phase in
                if case let .success(image) = phase {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .accessibilityIdentifier(background.accessibility.identifier)
                        .background(GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    height = proxy.size.height
                                }
                        })
                }
            }
        }
    }
}
