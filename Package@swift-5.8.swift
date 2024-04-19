// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NSAttributedStringBuilder",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "NSAttributedStringBuilder",
            targets: ["NSAttributedStringBuilder"]
        )
    ],
    targets: [
        .target(
            name: "NSAttributedStringBuilder",
            resources: [
                .copy("PrivacyInfo.xcprivacy")
            ]
        ),
        .testTarget(
            name: "NSAttributedStringBuilderTests",
            dependencies: ["NSAttributedStringBuilder"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
