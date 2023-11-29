// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        )
    ],
    dependencies: [
        .package(path: "../../")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: ["NSAttributedStringBuilder"]
        )
    ]
)
