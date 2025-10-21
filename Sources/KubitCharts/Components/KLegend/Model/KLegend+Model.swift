import Combine

/// This extension provides a model for the component.
extension KLegend {
    /// Class that contains all the necessary information to draw and make the component accessible.
    final class Model: ObservableObject {
        @Published var configuration: Configuration
        @Published var titleAlignment: TitleAlignment = .start
        @Published var orientation: Orientation = .horizontal()
        @Published var accessibility: Accessibility

        init(configuration: Configuration,
             titleAlignment: TitleAlignment = .start,
             orientation: Orientation = .horizontal(),
             accessibility: Accessibility) {
            self.configuration = configuration
            self.titleAlignment = titleAlignment
            self.orientation = orientation
            self.accessibility = accessibility
        }
    }
}
