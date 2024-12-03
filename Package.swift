// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LocalizationPackage",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(name: "LocalizationPackage", targets: ["LocalizationPackage"]),
  ],
  targets: [
    .target(
      name: "LocalizationPackage"
    ),
  ]
)
