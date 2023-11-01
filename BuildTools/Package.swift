// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [.macOS(.v11)],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.52.8")
    ],
    targets: [.target(name: "BuildTools", path: "")]
)
