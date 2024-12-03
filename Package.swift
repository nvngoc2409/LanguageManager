// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LanguageManager",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(name: "LanguageManager", targets: ["LanguageManager"]),
  ],
  targets: [
    .target(
      name: "LanguageManager",
      resources: [
        .process("languages/en_US"),
        .process("languages/th_TH")
      ]
    ),
  ]
)
