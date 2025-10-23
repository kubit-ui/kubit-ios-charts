public import SwiftUI

// MARK: - Axes
public extension KAxisChart {
    /// It updates X-axis model.
    /// - Parameter model: new X-axis model.
    /// - Returns: the updated ``KAxisChart`` instance.
    func xAxis(_ model: KAxis) -> KAxisChart {
        guard model != self.model.xAxis else {
            return self
        }
        let chart = self
        chart.model.xAxis = model
        return chart
    }

    /// It updates the Y-axis model.
    /// - Parameter model: new Y-axis model.
    /// - Returns: the updated ``KAxisChart`` instance.
    func yAxis(_ model: KAxis) -> KAxisChart {
        guard model != self.model.yAxis else {
            return self
        }
        let chart = self
        chart.model.yAxis = model
        return chart
    }
}

// MARK: - Shades
public extension KAxisChart {
    /// It adds the specified shade regions to the ``KAxisChart``.
    /// - Parameter regions: an array of ``KShadeRegion`` objects to add to the chart.
    /// - Returns: the updated ``KAxisChart`` instance.
    func addShade(regions: [KShadeRegion]) -> KAxisChart {
        let chart = self
        for region in regions {
            let alreadyContained = self.model.shadeRegions.contains {
                $0.origin == region.origin && $0.end == region.end && $0.color == region.color
            }
            if !alreadyContained {
                chart.model.shadeRegions.append(region)
            }
        }
        return chart
    }

    /// It adds ``KShadeRegion`` to ``KAxisChart``.
    /// - Parameter region: new instance of ``KShadeRegion`` to add.
    /// - Returns: the updated ``KAxisChart`` instance.
    func addShade(region: KShadeRegion) -> KAxisChart {
        let alradyContained = self.model.shadeRegions.contains {
            $0.origin == region.origin && $0.end == region.end && $0.color == region.color
        }
        guard !alradyContained else {
            return self
        }
        let chart = self
        chart.model.shadeRegions.append(region)
        return chart
    }

    /// It removes ``KShadeRegion`` from ``KAxisChart``.
    /// - Parameter region: instance of ``KShadeRegion`` to remove.
    /// - Returns: the updated ``KAxisChart`` instance.
    func removeShade(region: KShadeRegion) -> KAxisChart {
        let regionIndex = model.shadeRegions.firstIndex {
            $0.origin == region.origin && $0.end == region.end && $0.color == region.color
        }
        guard let regionIndex else {
            return self
        }
        let chart = self
        chart.model.shadeRegions.remove(at: regionIndex)
        return chart
    }

    /// It adds shade regions to the axis chart covering negative zones in the X and/or Y axes.
    /// - Parameter color: the color used to fill the negative shade regions.
    /// - Returns: the updated ``KAxisChart`` instance.
    func addNegativeShadeRegions(color: Color) -> KAxisChart {
        let xValues = model.xAxis.minValue...model.xAxis.maxValue
        let yValues = model.yAxis.minValue...model.yAxis.maxValue
        var regions = [KShadeRegion]()
        if xValues.lowerBound < 0 {
            regions.append(KShadeRegion(
                origin: CGPoint(x: xValues.lowerBound, y: .zero),
                end: CGPoint(x: 0, y: yValues.upperBound),
                color: color))
        }
        if yValues.lowerBound < 0 {
            regions.append(KShadeRegion(
                origin: CGPoint(x: 0, y: yValues.lowerBound),
                end: CGPoint(x: xValues.upperBound, y: 0),
                color: color))
        }
        if xValues.lowerBound < 0 && yValues.lowerBound < 0 {
            regions.append(KShadeRegion(
                origin: CGPoint(x: xValues.lowerBound, y: yValues.lowerBound),
                end: .zero,
                color: color))
        }
        let chart = self
        chart.model.shadeRegions.removeAll()
        chart.model.shadeRegions.append(contentsOf: regions)
        return chart
    }
}

// MARK: - Bars
public extension KAxisChart {
    /// It adds a bar chart to the current axis chart.
    /// - Parameter bar: an instance of ``KBar`` that contains all the information needed to display the bar chart.
    /// - Returns: an instance of ``KAxisChart`` with the bar chart data included.
    func addBar(_ bar: KBar) -> KAxisChart {
        let contains = charts.models.contains { chartModel in
            guard let chartModel = chartModel as? KBar else {
                return false
            }
            return chartModel == bar
        }
        guard !contains else {
            return self
        }
        let chart = self
        chart.charts.models.append(bar)
        return chart
    }

    /// It adds the specified bars to the chart.
    /// - Parameter bars: an array of ``KBar`` objects to add to the chart.
    /// - Returns: the updated ``KAxisChart`` instance.
    func addBars(_ bars: [KBar]) -> KAxisChart {
        var barsToAdd = [KBar]()
        for bar in bars {
            let contains = charts.models.contains { $0 as? KBar == bar }
            if !contains {
                barsToAdd.append(bar)
            }
        }

        guard !barsToAdd.isEmpty else {
            return self
        }
        let chart = self
        chart.charts.models.append(contentsOf: barsToAdd)
        return chart
    }
}

// MARK: - Background
public extension KAxisChart {
    /// It adds a custom background to the current axis chart.
    /// - Parameter source: an instance of ``KCustomBackground`` that contains all the information needed to
    /// display the custom background.
    /// - Returns: the updated ``KAxisChart`` instance with the background data included.
    func addBackground(_ source: KCustomBackground) -> KAxisChart {
        let contains = charts.models.contains { chartModel in
            guard let chartModel = chartModel as? KCustomBackground else {
                return false
            }
            return chartModel == source
        }
        guard !contains else {
            return self
        }
        let chart = self
        chart.charts.models.append(source)
        return chart
    }
}

// MARK: - Nodes
public extension KAxisChart {
    /// It adds a node to current axis chart.
    /// - Parameter node: instance of ``KNode`` that contains all the information needed to display the node.
    /// - Returns: the updated ``KAxisChart`` instance with the node data included.
    func addNode(_ node: KNode) -> KAxisChart {
        let contains = charts.models.contains { chartModel in
            guard let chartModel = chartModel as? KNode else {
                return false
            }
            return chartModel == node
        }
        guard !contains else {
            return self
        }
        let chart = self
        chart.charts.models.append(node)
        return chart
    }

    /// It adds the specified nodes to the current axis chart.
    /// - Parameter nodes: an array of ``KNode`` objects that contains all the information needed to display the nodes.
    /// - Returns: the updated ``KAxisChart`` instance with the nodes included.
    func addNodes(_ nodes: [KNode]) -> KAxisChart {
        var nodesToAdd = [KNode]()
        for node in nodes {
            let contains = charts.models.contains { $0 as? KNode == node }
            if !contains {
                nodesToAdd.append(node)
            }
        }

        guard !nodesToAdd.isEmpty else {
            return self
        }
        let chart = self
        chart.charts.models.append(contentsOf: nodesToAdd)
        return chart
    }

    /// It selects the specified node, or unselects the currently selected node if `node` is `nil`.
    /// - Parameter node: the ``KNode`` to select or `nil` to unselect the current node.
    /// - Returns: the updated ``KAxisChart`` instance.
    func selectNode(_ node: KNode?) -> KAxisChart {
        guard charts.selectedNode != node else {
            return self
        }
        let chart = self
        chart.charts.selectedNode = node
        return chart
    }
}

// MARK: - Lines
public extension KAxisChart {
    /// It adds a line to the chart.
    /// - Parameter line: an instance of ``KLine`` that contains all the information needed to display the line.
    /// - Returns: the updated ``KAxisChart`` instance.
    func addLine(_ line: KLine) -> KAxisChart {
        let contains = charts.models.contains { $0 as? KLine == line }
        guard !contains else {
            return self
        }
        let chart = self
        chart.charts.models.append(line)
        return chart
    }

    /// It adds the specified lines to the chart.
    /// - Parameter lines: an array of ``KLine`` objects that contains all the information needed to display the lines.
    /// - Returns: the updated ``KAxisChart`` instance.
    func addLines(_ lines: [KLine]) -> KAxisChart {
        var linesToAdd = [KLine]()
        for line in lines {
            let contains = self.charts.models.contains { $0 as? KLine == line }
            if !contains {
                linesToAdd.append(line)
            }
        }

        guard !linesToAdd.isEmpty else {
            return self
        }
        let chart = self
        chart.charts.models.append(contentsOf: linesToAdd)
        return chart
    }
}

// MARK: - Areas
public extension KAxisChart {
    /// It adds the specified area to the chart.
    /// - Parameter area: an instance of ``KArea`` that contains all the information needed to display the area.
    /// - Returns: the updated ``KAxisChart`` instance.
    func addArea(_ area: KArea) -> KAxisChart {
        let contains = charts.models.contains { $0 as? KArea == area }
        guard !contains else {
            return self
        }
        let chart = self
        chart.charts.models.append(area)
        return chart
    }

    /// It adds the specified areas to the chart.
    /// - Parameter areas: an array of ``KArea`` objects that contains all the information needed to display the areas.
    /// - Returns: the updated ``KAxisChart`` instance.
    func addAreas(_ areas: [KArea]) -> KAxisChart {
        var areasToAdd = [KArea]()
        for area in areas {
            let contains = self.charts.models.contains { $0 as? KArea == area }
            if !contains {
                areasToAdd.append(area)
            }
        }

        guard !areasToAdd.isEmpty else {
            return self
        }
        let chart = self
        chart.charts.models.append(contentsOf: areasToAdd)
        return chart
    }
}

// MARK: - Intersect Lines
public extension KAxisChart {
    /// It updates the horizontal intersect line for the ``KAxisChart``.
    /// This line is displayed when the user taps over a node. If `color` is `nil` or `width` is `.zero`, the line will not be shown.
    /// - Parameters:
    ///   - color: color of the intersect line.
    ///   - width: width of the intersect line. `1.0` by default.
    ///   - dashPattern: dash pattern of the intersect line. `[4, 4]` by default.
    /// - Returns: the updated ``KAxisChart`` instance.
    func setHorizontalIntersectLine(color: Color?, width: CGFloat = 1.0, dashPattern: [CGFloat] = [4, 4]) -> KAxisChart {
        var newIntersectLine: KIntersectLine?
        if let color, width > 0 {
            newIntersectLine = KIntersectLine(color: color, width: width, dashPattern: dashPattern, orientation: .horizontal)
        }
        let oldHorizontalLine = charts.models.first { model in
            if let model = model as? KIntersectLine, model.orientation == .horizontal {
                return true
            }
            return false
        } as? KIntersectLine
        guard oldHorizontalLine != newIntersectLine else {
            return self
        }

        let chart = self
        let oldHorizontalLineIndex = chart.charts.models.firstIndex { model in
            if let model = model as? KIntersectLine, model.orientation == .horizontal {
                return true
            }
            return false
        }
        if let oldHorizontalLineIndex {
            chart.charts.models.remove(at: oldHorizontalLineIndex)
        }
        if let newIntersectLine {
            chart.charts.models.append(newIntersectLine)
        }
        return chart
    }

    /// It updates ``KAxisChart`` vertical intersect lines. This line is shown when the user taps on a node. If color is `nil` or width is `.zero`, the line won't be shown.
    /// - Parameters:
    ///   - color: color of the intersect line.
    ///   - width: width of the intersect line. `1.0` by default.
    ///   - dashPattern: dash pattern of the intersect line. `[4, 4]` by default.
    /// - Returns: the updated ``KAxisChart`` instance.
    func setVerticalIntersectLine(color: Color?, width: CGFloat = 1.0, dashPattern: [CGFloat] = [4, 4]) -> KAxisChart {
        var newIntersectLine: KIntersectLine?
        if let color, width > 0 {
            newIntersectLine = KIntersectLine(color: color, width: width, dashPattern: dashPattern, orientation: .vertical)
        }
        let oldVerticalLine = charts.models.first { model in
            if let model = model as? KIntersectLine, model.orientation == .vertical {
                return true
            }
            return false
        } as? KIntersectLine
        guard oldVerticalLine != newIntersectLine else {
            return self
        }

        let chart = self
        let oldVerticalLineIndex = chart.charts.models.firstIndex { model in
            if let model = model as? KIntersectLine, model.orientation == .vertical {
                return true
            }
            return false
        }
        if let oldVerticalLineIndex {
            chart.charts.models.remove(at: oldVerticalLineIndex)
        }
        if let newIntersectLine {
            chart.charts.models.append(newIntersectLine)
        }
        return chart
    }
}

// MARK: - Interactions
public extension KAxisChart {
    ///  It sets a handler to be called when a bar is tapped in bar charts.
    /// - Parameter didTapOnBar: the closure that is triggered when a user taps over a bar.
    /// - Returns: the updated ``KAxisChart`` instance.
    func didTapOnBar(_ didTapOnBar: ((KBar) -> Void)?) -> KAxisChart {
        let chart = self
        chart.charts.didTapOnBar = didTapOnBar
        return chart
    }

    /// It sets a handler to be called when a node is selected in node charts or charts with nodes.
    /// - Parameter didSelectNode: the closure that is triggered when a user taps over a node.
    /// - Returns: the updated ``KAxisChart`` instance.
    func didSelectNode(_ didSelectNode: ((KNode) -> Void)?) -> KAxisChart {
        let chart = self
        chart.charts.didSelectNode = didSelectNode
        return chart
    }

    /// It  sets a handler to be called when a node is unselected in node charts or charts with nodes.
    /// - Parameter didUnselectNode: the closure that is triggered when a user taps over a node.
    /// - Returns: the updated ``KAxisChart`` instance.
    func didUnselectNode(_ didUnselectNode: ((KNode) -> Void)?) -> KAxisChart {
        let chart = self
        chart.charts.didUnselectNode = didUnselectNode
        return chart
    }
}
