#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension AttributedStringBuilding {

    /// Get the attribute of the last character.
    /// - Parameters:
    ///   - name: The name of the attribute.
    /// - Returns: The current attribute for a given key.
    func attribute<T>(_ name: NSAttributedString.Key) -> T? {
        let attributes = attributes()
        return attributes[name] as? T
    }

    /// Get the current attributed string.
    ///
    /// This is a convenience method to easily create an attributed string from the current context.
    /// - Returns: The current context as attributed string.
    func attributedString() -> NSAttributedString {
        mutableAttributedString()
    }

    /// Adds an attribute to the current attributed string. An existing attribute is overridden.
    /// - Parameters:
    ///   - name: The name of the attribute.
    ///   - value: The value of the attribute.
    /// - Returns: The modified attributed string.
    func addingAttribute(_ name: NSAttributedString.Key, value: Any) -> NSAttributedString {
        addingAttributes([name: value])
    }

    /// Appends a string to the existing attributed string. Existing attributes are added to the appended string.
    /// - Parameters:
    ///   - newString: The string that will be appended.
    /// - Returns: A modified attributed string.
    func addingString(_ newString: String) -> NSAttributedString {
        addingAttributedString(NSAttributedString(string: newString))
    }

    /// Adds a string to the current context. The existing attributes are applied to the string.
    /// - Parameters:
    ///   - newString: The string will be added to at the end.
    /// - Returns: The modified attributed string.
    func text(_ newString: String) -> NSAttributedString {
        addingString(newString)
    }

    /// Set the kerning of the text.
    /// - Parameters:
    ///   - kerning: The text kerning.
    /// - Returns: The modified attributed string.
    func kerning(_ kerning: Double) -> NSAttributedString {
        addingAttribute(.kern, value: NSNumber(value: kerning))
    }

    /// Add a spacing at the end of the attributed string.
    /// - Parameters:
    ///   - spacing: The type of `Spacing`. Default is `.standard` whitespace.
    /// - Returns: The modified attributed string.
    func space(_ spacing: Spacing = .standard) -> NSAttributedString {
        switch spacing {
        case .standard:
            return addingString("\u{0020}")
        case .enSpace:
            return addingString("\u{2002}")
        case .emSpace:
            return addingString("\u{2003}")
        #if !os(watchOS)
        case let .custom(width):
            let attachment = NSTextAttachment()
            attachment.bounds = .init(origin: .zero, size: .init(width: width, height: 0.001))
            return addingAttributedString(NSAttributedString(attachment: attachment))
        #endif
        }
    }

    func nonBreakingSpace() -> NSAttributedString {
        addingString("\u{00A0}")
    }

    func newline() -> NSAttributedString {
        addingString("\n")
    }

    func link(_ url: URL) -> NSAttributedString {
        addingAttribute(.link, value: url as NSURL)
    }

    func baselineOffset(_ offset: Double) -> NSAttributedString {
        addingAttribute(.baselineOffset, value: NSNumber(value: offset))
    }

    func ligature(_ option: Ligature) -> NSAttributedString {
        addingAttribute(.ligature, value: option.rawValue)
    }

    func textEffect(_ style: NSAttributedString.TextEffectStyle) -> NSAttributedString {
        addingAttribute(.textEffect, value: style as NSString)
    }

    func writingDirection(_ direction: NSAttributedStringBuilder.WritingDirection) -> NSAttributedString {
        addingAttribute(.writingDirection, value: [direction.rawValue])
    }

    /// Set the language of the text. This provides a backport for the key `.languageIdentifier`. When this attribute is set,
    /// it will be used to select localized glyphs (if supported by the font), and locale-specific line-breaking rules.
    /// - Parameters:
    ///   - languageCode: The language code of the language.
    /// - Returns: The modified attributed string.
    func language(_ languageCode: NSAttributedStringBuilder.LanguageCode) -> NSAttributedString {
        addingAttribute(NSAttributedString.Key(kCTLanguageAttributeName as String), value: languageCode.rawValue)
    }

    /// Set the language identifier of the text. The language identifier will be used for locale-specific line-breaking rules.
    /// - Parameters:
    ///   - languageCode: The language code identifier.
    /// - Returns: The modified attributed string.
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    func languageIdentifier(_ languageCode: Locale.LanguageCode) -> NSAttributedString {
        addingAttribute(.languageIdentifier, value: languageCode.identifier)
    }

    // MARK: - Paragraph styles

    func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        addingAttribute(.paragraphStyle, value: paragraphStyle)
    }

    func alignment(_ alignment: NSTextAlignment) -> NSAttributedString {
        addingParagraphStyle(alignment, keyPath: \.alignment)
    }

    func firstLineHeadIndent(_ indent: CGFloat) -> NSAttributedString {
        addingParagraphStyle(indent, keyPath: \.firstLineHeadIndent)
    }

    func headIndent(_ headIndent: CGFloat) -> NSAttributedString {
        addingParagraphStyle(headIndent, keyPath: \.headIndent)
    }

    func tailIndent(_ tailIndent: CGFloat) -> NSAttributedString {
        addingParagraphStyle(tailIndent, keyPath: \.tailIndent)
    }

    func lineHeightMultiple(_ height: CGFloat) -> NSAttributedString {
        addingParagraphStyle(height, keyPath: \.lineHeightMultiple)
    }

    func maximumLineHeight(_ height: CGFloat) -> NSAttributedString {
        addingParagraphStyle(height, keyPath: \.maximumLineHeight)
    }

    func minimumLineHeight(_ height: CGFloat) -> NSAttributedString {
        addingParagraphStyle(height, keyPath: \.minimumLineHeight)
    }

    func lineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        addingParagraphStyle(spacing, keyPath: \.lineSpacing)
    }

    func paragraphSpacing(_ spacing: CGFloat) -> NSAttributedString {
        addingParagraphStyle(spacing, keyPath: \.paragraphSpacing)
    }

    func paragraphSpacingBefore(_ spacing: CGFloat) -> NSAttributedString {
        addingParagraphStyle(spacing, keyPath: \.paragraphSpacingBefore)
    }

    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> NSAttributedString {
        addingParagraphStyle(lineBreakMode, keyPath: \.lineBreakMode)
    }

    func lineBreakStrategy(_ strategy: NSParagraphStyle.LineBreakStrategy) -> NSAttributedString {
        addingParagraphStyle(strategy, keyPath: \.lineBreakStrategy)
    }

    func hyphenationFactor(_ factor: Float) -> NSAttributedString {
        addingParagraphStyle(factor, keyPath: \.hyphenationFactor)
    }

    @available(iOS 15, macOS 13, watchOS 8, tvOS 15, *)
    func usesDefaultHyphenation(_ usesDefaultHyphenation: Bool) -> NSAttributedString {
        addingParagraphStyle(usesDefaultHyphenation, keyPath: \.usesDefaultHyphenation)
    }

    func allowsDefaultTighteningForTruncation(_ allows: Bool) -> NSAttributedString {
        addingParagraphStyle(allows, keyPath: \.allowsDefaultTighteningForTruncation)
    }

    func baseWritingDirection(_ direction: NSWritingDirection) -> NSAttributedString {
        addingParagraphStyle(direction, keyPath: \.baseWritingDirection)
    }

    func tabStops(_ tabStops: [NSTextTab], defaultInterval: CGFloat = 0) -> NSAttributedString {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.tabStops = tabStops
        paragraphStyle.defaultTabInterval = defaultInterval
        return addingAttribute(.paragraphStyle, value: paragraphStyle)
    }

    // MARK: - Platform dependent (typealias)

    func font(_ font: AFont) -> NSAttributedString {
        addingAttribute(.font, value: font)
    }

    func foregroundColor(_ color: AColor) -> NSAttributedString {
        addingAttribute(.foregroundColor, value: color)
    }

    func backgroundColor(_ color: AColor) -> NSAttributedString {
        addingAttribute(.backgroundColor, value: color)
    }

    func underline(_ style: NSUnderlineStyle = .single, color: AColor? = nil) -> NSAttributedString {
        var newAttributes: Attributes = [
            .underlineStyle: NSNumber(value: style.rawValue)
        ]

        color.map {
            newAttributes[.underlineColor] = $0
        }

        return addingAttributes(newAttributes)
    }

    func strikethrough(_ style: NSUnderlineStyle = .single, color: AColor? = nil) -> NSAttributedString {
        var newAttributes: Attributes = [
            .strikethroughStyle: NSNumber(value: style.rawValue)
        ]

        color.map {
            newAttributes[.strikethroughColor] = $0
        }

        return addingAttributes(newAttributes)
    }

    func shadow(
        offset: CGSize = .init(width: 1, height: 1),
        blurRadius: Double = 5.0,
        color: AColor? = nil
    ) -> NSAttributedString {
        let shadow: NSShadow = attribute(.shadow) ?? NSShadow()
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = CGFloat(blurRadius)
        color.map {
            shadow.shadowColor = $0
        }

        return addingAttribute(.shadow, value: shadow)
    }

    func stroke(width: Double = 2.0, color: AColor? = nil) -> NSAttributedString {
        var newAttributes: Attributes = [
            .strokeWidth: NSNumber(value: width)
        ]

        color.map {
            newAttributes[.strokeColor] = $0
        }

        return addingAttributes(newAttributes)
    }
}

// MARK: - All platforms but watchOS

#if !os(watchOS)
public extension AttributedStringBuilding {

    /// Adds an attachment to the whole string.
    /// - Parameters:
    ///   - attachment: The text attachment that will be added to the attributed string.
    /// - Returns: The modified attributed string.
    func attachment(_ attachment: NSTextAttachment) -> NSAttributedString {
        addingAttribute(.attachment, value: attachment)
    }
}
#endif

// MARK: - Internal Helpers

extension AttributedStringBuilding {

    func addingParagraphStyle<Value>(
        _ value: Value,
        keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, Value>
    ) -> NSAttributedString {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle[keyPath: keyPath] = value
        return addingAttribute(.paragraphStyle, value: paragraphStyle)
    }
}
