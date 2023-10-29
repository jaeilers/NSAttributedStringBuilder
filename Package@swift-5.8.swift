// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NSAttributedStringBuilder",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .watchOS(.v4),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "NSAttributedStringBuilder",
            targets: ["NSAttributedStringBuilder"]),
    ],
    targets: [
        .target(
            name: "NSAttributedStringBuilder"),
        .testTarget(
            name: "NSAttributedStringBuilderTests",
            dependencies: ["NSAttributedStringBuilder"]),
    ],
    swiftLanguageVersions: [.v5]
)
