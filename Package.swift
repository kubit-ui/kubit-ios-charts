// swift-tools-version: 6.1
// swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KubitCharts",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "KubitCharts",
            targets: ["KubitCharts"]
        )
    ],
    targets: [
        .target(
            name: "KubitCharts"
        )
    ]
)
