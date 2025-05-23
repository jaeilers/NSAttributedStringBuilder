# NSAttributedStringBuilder

![CI workflow](https://github.com/jaeilers/NSAttributedStringBuilder/actions/workflows/ci.yml/badge.svg?branch=main) [![codecov](https://codecov.io/github/jaeilers/NSAttributedStringBuilder/graph/badge.svg?token=VzjqpuljEY)](https://codecov.io/github/jaeilers/NSAttributedStringBuilder) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjaeilers%2FNSAttributedStringBuilder%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/jaeilers/NSAttributedStringBuilder) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjaeilers%2FNSAttributedStringBuilder%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/jaeilers/NSAttributedStringBuilder) ![](https://img.shields.io/badge/SwiftUI-compatible-blue)

The `NSAttributedStringBuilder` is an easy to use attributed string builder with extended modifier support (bold/italic, image, custom spacings etc.) that supports most platforms and can be extended easily.

You can add more functionality by extending `AttributedStringBuilding`. All extensions of `AttributedStringBuilding` are available to `String`, `NSAttributedString`, `UIImage` and `NSImage` which conform to the protocol.

## Features

- [x] Supports most of `NSAttributedString.Key`
- [x] Flexible composition of strings, images etc.
- [x] Configure attributes separately (inspired by `AttributeContainer`)
- [x] Declarative syntax
- [x] SwiftUI compatible
- [x] Fully covered by unit tests

## Installation

### CocoaPods

Add the following to your `Podfile` to integrate `NSAttributedStringBuilder` into your project:

```Ruby
pod 'NSAttributedStringBuilder-jaeilers', '~> 0.4.0'
```

### Swift Package Manager

If you're using Xcode to manage your dependencies, select your project, **Package Dependencies** and add the package by entering the url [https://github.com/jaeilers/NSAttributedStringBuilder](https://github.com/jaeilers/NSAttributedStringBuilder).

For projects with a separate `Package.swift`, add the dependency to your package manifest:

```Swift
dependencies: [
    .package(url: "https://github.com/jaeilers/NSAttributedStringBuilder", .upToNextMajor(from: "0.4.0"))
]
```

## Usage

You can compose attributed strings either with result builder or with attributed string concatenation (operator overloading of `+`). There is no need for additional types:

```Swift
let attributedString = NSAttributedString {
    "Hello"
        .font(.preferredFont(forTextStyle: .body))
        .italic()
        .foregroundColor(.green)
        .underline()

    Space()

    "World"
        .font(.preferredFont(forTextStyle: .headline))
        .bold()
        .foregroundColor(.orange)
        .kerning(2.0)
        .baselineOffset(-1)
}

// or

let attributedString = "Hello"
    .font(.preferredFont(forTextStyle: .body))
    .italic()
    .foregroundColor(.green)
    .underline()
+ Space()
+ "World"
    .font(.preferredFont(forTextStyle: .headline))
    .bold()
    .foregroundColor(.orange)
    .kerning(2.0)
    .baselineOffset(-1)
```

Write your attributed strings how you prefer:

```Swift
let attributedString = NSAttributedString {
    UIImage.checkmark.attributedString()

    Space(.custom(1.0))

    "The quick brown fox jumps over the lazy dog."
        .attributedString()

    Newline()

    UIImage.add.attributedString()
}

// or 

let attributedString = UIImage.checkmark
    .space(.custom(1.0))
    .text("The quick brown fox jumps over the lazy dog.")
    .newline()
    .image(UIImage.add)
```

You can also configure and reuse your attributes separately from your attributed strings:

```Swift
let attributes = Attributes()
    .font(.systemFont(ofSize: 16))
    .italic()
    .underline()

let attributedString = NSAttributedString {
    "Hello"
        .addingAttributes(attributes)
        .foregroundColor(.systemBlue)

    Space()

    "World!"
        .addingAttributes(attributes)
        .foregroundColor(.systemTeal)
}
```

## How to add your own modifiers

You can add your own modifiers for missing attributes or combine multiple attributes by extending `AttributedStringBuilding`.
All extensions are automatically available to all types conforming to the protocol (UIImage/NSImage, String & NSAttributedString).

Adding an extension isn't always necessary. If you just want to add an attribute, call `addingAttribute(_:value:)` to add an attribute to the whole range of the attributed string.

```Swift
public extension AttributedStringBuilding {

    /// Combine multiple modifiers in one.
    func linebreak(_ breakMode: NSLineBreakMode, strategy: NSParagraphStyle.LineBreakStrategy = .standard) -> NSAttributedString {
        lineBreakMode(breakMode)
            .lineBreakStrategy(strategy)
    }

    /// Add support for another modifier.
    func accessibilityStrikethrough(_ hasStrikethrough: Bool) -> NSAttributedString {
        addingAttribute(.accessibilityStrikethrough, value: NSNumber(value: hasStrikethrough))
    }
}
```

## Other

This project is inspired by [ethanhuang13/NSAttributedStringBuilder](https://github.com/ethanhuang13/NSAttributedStringBuilder) and [svdo/swift-RichString](https://github.com/svdo/swift-RichString).
