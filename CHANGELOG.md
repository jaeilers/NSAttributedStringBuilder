# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added conformance to `Hashable`, `Codable` and `Sendable` to custom types: `LanguageCode`, `Ligature`, `Spacing`, `SpellingState` & `WritingDirection`

### Changed

- Updated Swift toolchain to Swift 6
- Updated github actions pipeline to Xcode 16
- Migrated XCTest cases to Swift Testing

## [0.3.1] - 2024-04-21

### Added

- Added visionOS target to Xcode project
- Added swift package index badges to readme

### Fixed

- Removed visionOS platform from package for Swift 5.8

## [0.3.0] - 2024-04-18

### Added

- Added Attributes extensions to create attributes separately from attributed strings
- Added visionOS support for Swift Package Manager
- Added support for some accessibility keys
- Added superscript for iOS and tvOS

### Changed

- Changed logic that existing colors (stroke, strikethrough & shadow) are overridden
- Updated CI dependencies and Xcode project

## [0.2.1] - 2024-04-01

### Added

- Added code coverage reports & badge for all platforms (iOS, macOS, tvOS & watchOS)
- Added monospaced, condensed and tracking modifiers
- Added Swift Package Index documentation
- Added empty privacy manifest

## [0.2.0] - 2023-12-03

### Added

- Added Changelog
- Added CI workflow status badge
- Added support for glyphInfo and markedClauseSegment
- Added support for optionals, conditionals and limited availability in result builder
- Added CocoaPods release pipeline

### Changed

- Improved fastlane lane test_all
- Added examples for watchOS and tvOS
- Changed module name to NSAttributedStringBuilder
- Updated podspec summary and improved source files specification
- Restricted result build to initialization only

### Removed

- Accessibility label and hint from image modifier for iOS/tvOS

## [0.1.0] - 2023-11-11

### Added

- Initial Release

[unreleased]: https://github.com/jaeilers/NSAttributedStringBuilder/compare/0.3.1...HEAD
[0.3.1]: https://github.com/jaeilers/NSAttributedStringBuilder/releases/tag/0.3.1
[0.3.0]: https://github.com/jaeilers/NSAttributedStringBuilder/releases/tag/0.3.0
[0.2.1]: https://github.com/jaeilers/NSAttributedStringBuilder/releases/tag/0.2.1
[0.2.0]: https://github.com/jaeilers/NSAttributedStringBuilder/releases/tag/0.2.0
[0.1.0]: https://github.com/jaeilers/NSAttributedStringBuilder/releases/tag/0.1.0
