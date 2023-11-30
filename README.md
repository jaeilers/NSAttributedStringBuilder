# NSAttributedStringBuilder

![CI workflow](https://github.com/jaeilers/NSAttributedStringBuilder/actions/workflows/ci.yml/badge.svg?branch=main) ![](https://img.shields.io/badge/Swift-5.8_5.9-orange) ![](https://img.shields.io/badge/Platforms-macOS_|_iOS_|_tvOS_|_watchOS-lightblue) ![](https://img.shields.io/badge/License-MIT-green) ![](https://img.shields.io/badge/SwiftUI-compatible-blue)

The `NSAttributedStringBuilder` is an easy to use attributed string builder with extended modifier support (bold/italic, image, custom spacings etc.) that supports most platforms, can be extended easily and has accessibility support. 

You can add more functionality by extending `AttributedStringBuilding`. All extensions of `AttributedStringBuilding` are available to `String`, `NSAttributedString`, `UIImage` and `NSImage` which conform to the protocol.

## Features

- [x] Supports most of `NSAttributedString.Key`
- [x] Flexible composition of strings, images etc.
- [x] Declarative syntax
- [x] SwiftUI compatible
- [x] Accessibility support
- [x] Fully covered by unit tests

## Installation

### CocoaPods

Add the following to your `Podfile` to integrate `NSAttributedStringBuilder` into your project:

```
pod 'NSAttributedStringBuilder-jaeilers', :git => 'https://github.com/jaeilers/NSAttributedStringBuilder.git', :tag => '0.1.0'
```

### Swift Package Manager

If you're using Xcode to manage your dependencies, select your project, **Package Dependencies** and add the package by entering the url [https://github.com/jaeilers/NSAttributedStringBuilder](https://github.com/jaeilers/NSAttributedStringBuilder).

For projects with a separate `Package.swift`, add the dependency to your package manifest:

```
dependencies: [
    .package(url: "https://github.com/jaeilers/NSAttributedStringBuilder", .upToNextMajor(from: "0.1.0"))
]
```

## Examples

You can compose attributed strings either with result builder or with attributed string concatenation (operator overloading of `+`). There is no need for additional types:

```Swift
let attributedString = NSAttributedString {
    "Hello"
        .font(.preferredFont(forTextStyle: .body))
        .italic()
        .foregroundColor(.green)

    Space()

    "World"
        .font(.preferredFont(forTextStyle: .headline))
        .bold()
        .foregroundColor(.orange)
        .kerning(2.0)
}

// or

let attributedString = "Hello"
    .font(.preferredFont(forTextStyle: .body))
    .italic()
    .foregroundColor(.green)
+ Space()
+ "World"
    .font(.preferredFont(forTextStyle: .headline))
    .bold()
    .foregroundColor(.orange)
    .kerning(2.0)
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

## Other

This project is inspired by [ethanhuang13/NSAttributedStringBuilder](https://github.com/ethanhuang13/NSAttributedStringBuilder) and [svdo/swift-RichString](https://github.com/svdo/swift-RichString).
