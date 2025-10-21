import KubitCharts
import SwiftUI

extension KAxis {
    var hasLabels: Bool {
        points.contains { !$0.labelStyle.value.isNilOrEmpty }
    }
}
