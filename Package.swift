// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "AnalyticsClient",
  products: [
    .library(
      name: "AnalyticsClient",
      targets: ["AnalyticsClient"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "AnalyticsClient",
      dependencies: []),
    .testTarget(
      name: "AnalyticsClientTests",
      dependencies: ["AnalyticsClient"]),
  ]
)
