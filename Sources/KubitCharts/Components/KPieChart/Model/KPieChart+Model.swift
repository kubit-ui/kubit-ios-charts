import Combine
import SwiftUI

extension KPieChart {
    /// Class that contains all the needed information to draw the component and make it accessible.
    final class Model: ObservableObject {
        /// Configuration of the component.
        @Published var configuration: Configuration
        /// Visual configuration of the component.
        @Published var style: StyleConfiguration
        /// Accessibility information required for the component to be accessible and testable.
        @Published var accessibility: Accessibility

        /// It creates model with specified values.
        ///
        /// - Parameters:
        ///   - configuration: configuration of the component.
        ///   - style: visual configuration of the component.
        ///   - accessibility: necessary accessibility information for the component.
        init(configuration: Configuration, style: StyleConfiguration, accessibility: Accessibility) {
            self.configuration = configuration
            self.style = style
            self.accessibility = accessibility
        }
    }
}
