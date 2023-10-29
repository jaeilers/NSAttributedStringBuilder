# NSAttributedStringBuilder

![](https://img.shields.io/badge/Swift-5.8_5.9-orange) ![](https://img.shields.io/badge/Platforms-macOS_|_iOS_|_tvOS_|_watchOS-lightblue) ![](https://img.shields.io/badge/License-MIT-green) ![](https://img.shields.io/badge/SwiftUI-compatible-blue) 

The `NSAttributedStringBuilder` is an easy to use attributed string builder with extended modifier support (bold/italic, image, custom spacings etc.) that supports most platforms, can be extended easily and has accessibility support.

## Features

- Supports most of `NSAttributedString.Key`
- Flexible composition of strings, images etc.
- Declarative syntax
- SwiftUI compatible
- Accessibility support
- Fully covered by unit tests

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
