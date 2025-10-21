import Foundation
import KubitCharts

extension KAxis {
    var innerStartPadding: CGFloat {
        labelsStyle.position == .start && hasLabels ? 0.0 : 12.0
    }

    var innerEndPadding: CGFloat {
        labelsStyle.position == .end && hasLabels ? 0.0 : 12.0
    }

    var startPadding: CGFloat {
        labelsStyle.position == .start && hasLabels ? 0.0 : 6.0
    }

    var endPadding: CGFloat {
        labelsStyle.position == .end && hasLabels ? 0.0 : 6.0
    }
}
