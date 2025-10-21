import Combine
import SwiftUI

/// This extension provides a model for the component.
extension KAxisChart {
    final class ChartsModel: ObservableObject {
        @Published var models: [KubitChartModelContract] = []
        @Published var didTapOnBar: ((KBar) -> Void)?
        @Published var selectedNode: KNode?
        @Published var didSelectNode: ((KNode) -> Void)?
        @Published var didUnselectNode: ((KNode) -> Void)?

        init(models: [KubitChartModelContract] = []) {
            self.models = models
        }
    }
}
