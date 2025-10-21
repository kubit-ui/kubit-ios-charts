import Combine

extension KImage {
    /// Class that contains all the necessary information to draw the component and make it accessible.
    final class Model: ObservableObject {
        /// Visual configuration of the component.
        @Published var configuration: Configuration

        /// It creates a ViewModel with specific values.
        ///
        /// - Parameter configuration: configuration of the component.
        init(configuration: Configuration) {
            self.configuration = configuration
        }
    }
}
