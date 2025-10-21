import SwiftUI

/// #  KCustomBackgroundView
///
/// [Figma design]
/// (https://www.figma.com/design/XJnmdNlhMwmyx4QpGGpIN3/-R.8--Kubit-Global-Documentation?node-id=105199-295634&t=gAeJoHOWllHv94Xr-1)
///
/// ## How to use it:
/// ```
/// KAxisChart()
///     .addBackground(
///         KCustomBackground(source: .remote(url: URL(string: "url")),
///         accessibility: KCustomBackground.Accessibility(identifier: "RemoteSourceIdentifier")))
/// ```
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

private struct KCustomBackgroundViewPreview: View {
    var body: some View {
        KAxisChart()
         .addBackground(
            KCustomBackground(source: .local(name: "map", bundle: .module), accessibilityIdentifier: ""))
            .padding()
    }
}

#Preview {
    KCustomBackgroundViewPreview()
}
