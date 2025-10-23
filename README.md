# Kubit Charts iOS

## Index

* [Description](#description)
* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
  * [Example: Bar Chart](#example-bar-chart)
  * [Example: Line Chart](#example-line-chart)
  * [Example: Intersect Line Chart](#example-axis-chart)
  * [Example: Axis Chart](#example-axis-chart)
    * [Using custom background](#using-custom-background)
    * [Using nodes](#using-node)
    * [Using legend](#using-legend)
  * [Example: Pie Chart](#example-pie-chart)
  * [Example: Zoom Area Chart](#example-zoom-area-chart)
* [Contributions](#contributions)

## Description

KubitCharts is an iOS library that contains chart components based on the Kubit Design System created by the UX/UI Team at ODS(Open Digital Services). The chart components included in this library help to develop scalable and configurable charts of different types using the provided data.

This repository includes the following libraries:

* **KubitCharts**: The main library containing the chart components.
* **Storybook**: Previews of each component, mainly used for testing, quality assurance and to give basic examples of the implementation.

## Requirements

0. Required software:

    * **Xcode 16 or newer** (16.4 recommended)
  
## Installation

1. To install KubitCharts you can use the Swift Packet Manager (SPM).
In Xcode navigate to File → Swift Packages → Add Package Dependency...
Use this URL to add the dependency: `https://github.com/kubit-ui/kubit-ios-charts`

2. If you want to add the test the demo app to see the implementation examples, follow the next steps:
- Open the `Demo/KubitChartsDemo.xcodeproj` file.
   

## Usage

Import the package in the file you would like to use it: `import KubitCharts`

### Example: Bar Chart

The following example demonstrates how to initialize and configure a bar chart using the KubitCharts library:
```
import KubitCharts

let barChart = BarChartView()
barChart.data = [
    BarChartDataEntry(x: 1.0, y: 10.0),
    BarChartDataEntry(x: 2.0, y: 20.0),
    BarChartDataEntry(x: 3.0, y: 30.0)
]
barChart.title = "Monthly Sales"
view.addSubview(barChart)
barChart.configureAppearance(with: .default)
```
![Bar Chart](/assets/BarChart.gif)

### Example: Line Chart

The following example demonstrates how to initialize and configure a line chart:
```
import KubitCharts

let lineChart = LineChartView()
lineChart.data = [
    LineChartDataEntry(x: 1.0, y: 5.0),
    LineChartDataEntry(x: 2.0, y: 15.0),
    LineChartDataEntry(x: 3.0, y: 25.0)
]
lineChart.title = "User Trends"
lineChart.configureAppearance(with: .light)
view.addSubview(lineChart)
```

![Line Chart](/assets/LineChart.gif)

### Example: Intersect Line Chart

The following example demonstrates how to initialize and configure a intersect line chart:
```
import KubitCharts

let xAxis = SBAxisHelper.defaultAxis(position: .end, label0: "V0", label: "VX")
let yAxis = SBAxisHelper.defaultAxis(position: .start, label0: "V0", label: "VY")
KAxisChart()
.xAxis(xAxis)
.yAxis(yAxis)
.addNodes([
.polygon(
    position: KShape.Position(center: CGPoint(x: 2.0, y: 2.0), xRadius: 0.2),
    numberOfVertices: 4,
    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
    accessibility: .decorative(identifier: "Square1")),
.polygon(
    position: KShape.Position(center: CGPoint(x: 1.0, y: 2.0), xRadius: 0.2),
    numberOfVertices: 4,
    style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
    accessibility: .decorative(identifier: "Square2"))
])
.setHorizontalIntersectLine(color: Color.green)
```

![Intersect Line Chart](/assets/IntersectLineChart.gif)

### Example: Axis Chart
The following example demonstrates how to initialize and configure a axis chart:
```
import KubitCharts

let xAxis = KAxisBuilder()
    .addPointWithDefaultSolidLine(0, labelStyle: .labeled("0"))
    .addPointWithDefaultSolidLine(100, labelStyle: .labeled("100"))
    .setLabelsViewPosition(.start)
    .build()

let yAxis = KAxisBuilder()
    .addPointWithDefaultSolidLine(0, labelStyle: .labeled("0"))
    .addPointWithDefaultSolidLine(100, labelStyle: .labeled("100"))
    .setLabelsViewPosition(.start)
    .build()

 KAxisChart()
 .xAxis(xAxis)
 .yAxis(yAxis)
 ```
 
![Axis Chart](/assets/AxisChart.gif)

### Using custom background
The following example demonstrates how to use a custom background into an axis chart:
```
import KubitCharts

KAxisChart()
    .addBackground(
        KCustomBackground(source: .remote(url: URL(string: "url")),
        accessibility: KCustomBackground.Accessibility(identifier: "RemoteSourceIdentifier")))

 ```
 
![Custom background](/assets/CustomBackground.gif)

### Using nodes
The following example demonstrates how to use nodes into an axis chart:
```
import KubitCharts

let nodes = ([
    .polygon(
        position: KShape.Position(center: CGPoint(x: 2.0, y: 2.0), xRadius: 0.2),
        numberOfVertices: 4,
        style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
        accessibility: .decorative(identifier: "Square1")),
    .polygon(
        position: KShape.Position(center: CGPoint(x: 1.0, y: 2.0), xRadius: 0.2),
        numberOfVertices: 4,
        style: KShape.Style(fillColor: Color.black.opacity(0.5), borderColor: Color.black, borderWidth: 1.0),
        accessibility: .decorative(identifier: "Square2"))
])
KAxisChart()
    .xAxis(xAxis)
    .yAxis(yAxis)
    .addNodes(nodes)
 ```
 
![Node](/assets/Node.gif)

### Using legend
The following example demonstrates how to use legends into an axis chart:
```
import KubitCharts

 KLegend(title: "Title", identifier: "KLegend.America.Identifier")
     .value("30%", secondaryValue: "5%")
     .colorView(.black)
     .titleFont(...)
     .titleAlignment(.end)
     .orientation(.vertical)
 ```
 
![Legend](/assets/Legend.gif)

### Example: Pie Chart

The following example demonstrates how to initialize and configure a zoom area chart:

```
import KubitCharts

let pieChart = PieChartView()
pieChart.data = [
    PieChartDataEntry(value: 40.0, label: "iOS"),
    PieChartDataEntry(value: 30.0, label: "Android"),
    PieChartDataEntry(value: 30.0, label: "Web")
]
pieChart.title = "User Distribution"
pieChart.configureAppearance(with: .dark)
view.addSubview(pieChart)
```

![Pie Chart](/assets/PieChart.gif)

### Example: Zoom Area Chart

The following example demonstrates how to initialize and configure a pie chart:

```
import KubitCharts

var zoomLine: KLine {
let points: [CGPoint] = [
    CGPoint.zero,
    CGPoint(x: 1.0, y: 1)]
let KLine(
    points: points,
    appearance: .rounded,
    style: .solid,
    zoomable: KLine.Zoomable(startHandle: lowerBound, endHandle: upperBound, points: points),
    accessibilityIdentifier: "zoomlineIdentifier")
}

let axisChart = KAxisChart()
.xAxis(xAxis)
.yAxis(yAxis)
.addLines([zoomLine])

let zoomAreaChart = KZoomAreaChart(
startHandle: $startHandle,
endHandle: $endHandle,
content: { axisChart },
opacityColor: Color.blue)
```

![Zoom Area Chart](/assets/ZoomAreaChart.gif)

## Contributions

Contributions are welcome. Please follow the steps below to contribute:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Submit a pull request with a detailed description of the changes.
