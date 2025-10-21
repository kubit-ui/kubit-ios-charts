import Foundation

extension KAxisChart {
    struct InnerPaddings {
        var top: CGFloat
        var leading: CGFloat
        var bottom: CGFloat
        var trailing: CGFloat
    }
}

// MARK: - Internal
extension KAxisChart.InnerPaddings {
    var vertical: CGFloat {
        top + bottom
    }

    var horizontal: CGFloat {
        leading + trailing
    }
}
