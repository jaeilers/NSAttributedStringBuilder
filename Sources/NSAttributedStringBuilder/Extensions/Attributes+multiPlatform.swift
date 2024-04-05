#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension Attributes {

    /// Get the attribute for the given key.
    /// - Parameters:
    ///   - key: The key of the attribute.
    /// - Returns: The attribute for a given key.
    func attribute<T>(_ key: NSAttributedString.Key) -> T? {
        self[key] as? T
    }

    /// Merges the existing attributes with the new attributes.
    /// - Parameters:
    ///   - newAttributes: The attributes will be merged with the existing attributes.
    ///   The same keys are overridden by the new attributes.
    /// - Returns: The modified attributes.
    func addingAttributes(_ newAttributes: Attributes) -> Attributes {
        newAttributes.merging(self) { new, _ in new }
    }

    /// Set a new attribute and override an existing value if present.
    /// - Parameters:
    ///   - key: The attributed string key of the value.
    ///   - value: The new value that is set for the provided key.
    /// - Returns: The modified attributes.
    func addingAttribute(_ key: NSAttributedString.Key, value: Any) -> Attributes {
        var newAttributes = self
        newAttributes[key] = value
        return newAttributes
    }

    /// Get the mutable paragraph style of the last character. If none exist, a new paragraph style is created.
    /// - Returns: A copy of the current paragraph style.
    func mutableParagraphStyle() -> NSMutableParagraphStyle {
        guard let paragraphStyle: NSParagraphStyle = attribute(.paragraphStyle) else {
            return NSMutableParagraphStyle()
        }

        return paragraphStyle.mutableCopy() as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
    }

    /// Set the kerning of the text.
    /// - Parameters:
    ///   - kerning: The text kerning. A kerning of 0 means it is disabled.
    /// - Returns: The modified attributes.
    func kerning(_ kerning: Double) -> Attributes {
        addingAttribute(.kern, value: NSNumber(value: kerning))
    }

    /// Set a link with url.
    /// - Parameters:
    ///   - url: The url for the link attribute.
    /// - Returns: The modified attributes.
    func link(_ url: URL) -> Attributes {
        addingAttribute(.link, value: url as NSURL)
    }

    /// Set the baseline offset of the text.
    /// - Parameters:
    ///   - offset: The baseline offset.
    /// - Returns: The modified attributes.
    func baselineOffset(_ offset: Double) -> Attributes {
        addingAttribute(.baselineOffset, value: NSNumber(value: offset))
    }

    /// Set the ligature option of the text.
    /// - Parameters:
    ///   - option: The ligature option. The font must support ligatures.
    /// - Returns: The modified attributes.
    func ligature(_ option: Ligature) -> Attributes {
        addingAttribute(.ligature, value: option.rawValue)
    }

    /// Set the text effect of the text.
    /// - Parameters:
    ///   - style: The text effect style.
    /// - Returns: The modified attributes.
    func textEffect(_ style: NSAttributedString.TextEffectStyle) -> Attributes {
        addingAttribute(.textEffect, value: style as NSString)
    }

    /// Set the writing direction of the text.
    /// - Parameters:
    ///   - direction: The direction options for string. See `WritingDirection` for options.
    /// - Returns: The modified attributes.
    func writingDirection(_ direction: NSAttributedStringBuilder.WritingDirection) -> Attributes {
        addingAttribute(.writingDirection, value: [direction.rawValue])
    }

    /// Set the language of the text.
    ///
    /// This provides a backport for the key `.languageIdentifier`.
    /// When this attribute is set, it will be used to select localized glyphs (if supported by the font),
    /// and locale-specific line-breaking rules.
    /// - Parameters:
    ///   - languageCode: The language code of the language.
    /// - Returns: The modified attributes.
    func language(_ languageCode: NSAttributedStringBuilder.LanguageCode) -> Attributes {
        addingAttribute(NSAttributedString.Key(kCTLanguageAttributeName as String), value: languageCode.rawValue)
    }

    /// Set the language identifier of the text.
    ///
    /// The language identifier will be used for locale-specific line-breaking rules.
    /// - Parameters:
    ///   - languageCode: The language code identifier.
    /// - Returns: The modified attributes.
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    func languageIdentifier(_ languageCode: Locale.LanguageCode) -> Attributes {
        addingAttribute(.languageIdentifier, value: languageCode.identifier)
    }

    /// Set the tracking of the text.
    ///
    /// 'Tracking' is similar to kerning that it changes the spacing between the letters,
    /// but kerning tries to keep ligatures where tracking does not. If you set tracking and kerning at the same time
    /// then tracking overrides kerning. Both cannot be used a the same time.
    /// - Parameters:
    ///   - tracking: The tracking changes the spacing between the letters. A tracking of 0 means it is disabled.
    /// - Returns: The modified attributes.
    @available(iOS 14, tvOS 14, watchOS 7, *)
    func tracking(_ tracking: Double) -> Attributes {
        addingAttribute(.tracking, value: NSNumber(value: tracking))
    }
}

// MARK: - Platform dependent (typealias)

public extension Attributes {

    /// Set the font to the attributes.
    /// - Parameters:
    ///   - font: The platform dependent font.
    /// - Returns: The modified attributes.
    func font(_ font: AFont) -> Attributes {
        addingAttribute(.font, value: font)
    }

    /// Set the foreground color to the attributes.
    /// - Parameters:
    ///   - color: The new color of the text and images.
    /// - Returns: The modified attributes.
    func foregroundColor(_ color: AColor) -> Attributes {
        addingAttribute(.foregroundColor, value: color)
    }

    /// Set the background color to the attributes.
    /// - Parameters:
    ///   - color: The new background color.
    /// - Returns: The modified attributes.
    func backgroundColor(_ color: AColor) -> Attributes {
        addingAttribute(.backgroundColor, value: color)
    }

    /// Set the underline style of the text.
    /// - Parameters:
    ///   - style: The underline style of the text. Default is `single`.
    ///   - color: The color of the underline. The `foregroundColor` is used when no color is set. Default is `nil`.
    /// - Returns: The modified attributes.
    func underline(_ style: NSUnderlineStyle = .single, color: AColor? = nil) -> Attributes {
        var newAttributes = self
        newAttributes[.underlineStyle] = NSNumber(value: style.rawValue)
        color.map {
            newAttributes[.underlineColor] = $0
        }

        return newAttributes
    }

    /// Set the strike through style of the text.
    /// - Parameters:
    ///   - style: The strike through style of the text. Default is `single`.
    ///   - color: The color of the strike through. The `foregroundColor` is used when no color is set.
    ///   Default is `nil`.
    /// - Returns: The modified attributes.
    func strikethrough(_ style: NSUnderlineStyle = .single, color: AColor? = nil) -> Attributes {
        var newAttributes = self
        newAttributes[.strikethroughStyle] = NSNumber(value: style.rawValue)
        color.map {
            newAttributes[.strikethroughColor] = $0
        }

        return newAttributes
    }

    /// Set the shadow style of the text.
    ///
    /// Existing values are not overridden by passing `nil`. (e.g. `color`)
    /// - Parameters:
    ///   - offset: The offset of the shadow. Default is `width: 1` and `height: 1`.
    ///   - blurRadius: The blur radius of the shadow. Default is `5.0`.
    ///   - color: The color of the shadow. Default is `nil` which results in `black` with an alpha value of 1/3.
    /// - Returns: The modified attributes.
    func shadow(
        offset: CGSize = .init(width: 1, height: 1),
        blurRadius: Double = 5.0,
        color: AColor? = nil
    ) -> Attributes {
        let shadow: NSShadow = attribute(.shadow) ?? NSShadow()
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = CGFloat(blurRadius)
        color.map {
            shadow.shadowColor = $0
        }

        return addingAttribute(.shadow, value: shadow)
    }

    /// Set the stroke around the glyphs of the text.
    ///
    /// Existing values are not overridden by passing `nil`. (e.g. `color`)
    /// - Parameters:
    ///   - width: The width of the stroke.
    ///   Value is `>0`: Stroke border line without fill,
    ///   value is `0`: Fill content only and
    ///   value is `<0`:  Both stroke and border line and fill content.
    ///   Default is `2.0`.
    ///   - color: The color of the stroke. When no color is set, the `foregroundColor` is used. Default is `nil`.
    /// - Returns: The modified attributes.
    func stroke(width: Double = 2.0, color: AColor? = nil) -> Attributes {
        var newAttributes = self
        newAttributes[.strokeWidth] = NSNumber(value: width)
        color.map {
            newAttributes[.strokeColor] = $0
        }

        return newAttributes
    }
}

// MARK: - Paragraph Styles

public extension Attributes {

    func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> Attributes {
        addingAttribute(.paragraphStyle, value: paragraphStyle)
    }

    func alignment(_ alignment: NSTextAlignment) -> Attributes {
        addingParagraphStyle(alignment, keyPath: \.alignment)
    }

    func firstLineHeadIndent(_ indent: CGFloat) -> Attributes {
        addingParagraphStyle(indent, keyPath: \.firstLineHeadIndent)
    }

    func headIndent(_ headIndent: CGFloat) -> Attributes {
        addingParagraphStyle(headIndent, keyPath: \.headIndent)
    }

    func tailIndent(_ tailIndent: CGFloat) -> Attributes {
        addingParagraphStyle(tailIndent, keyPath: \.tailIndent)
    }

    func lineHeightMultiple(_ height: CGFloat) -> Attributes {
        addingParagraphStyle(height, keyPath: \.lineHeightMultiple)
    }

    func minimumLineHeight(_ height: CGFloat) -> Attributes {
        addingParagraphStyle(height, keyPath: \.minimumLineHeight)
    }

    func maximumLineHeight(_ height: CGFloat) -> Attributes {
        addingParagraphStyle(height, keyPath: \.maximumLineHeight)
    }

    func lineSpacing(_ spacing: CGFloat) -> Attributes {
        addingParagraphStyle(spacing, keyPath: \.lineSpacing)
    }

    func paragraphSpacing(_ spacing: CGFloat) -> Attributes {
        addingParagraphStyle(spacing, keyPath: \.paragraphSpacing)
    }

    func paragraphSpacingBefore(_ spacing: CGFloat) -> Attributes {
        addingParagraphStyle(spacing, keyPath: \.paragraphSpacingBefore)
    }

    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Attributes {
        addingParagraphStyle(lineBreakMode, keyPath: \.lineBreakMode)
    }

    func lineBreakStrategy(_ strategy: NSParagraphStyle.LineBreakStrategy) -> Attributes {
        addingParagraphStyle(strategy, keyPath: \.lineBreakStrategy)
    }

    func hyphenationFactor(_ factor: Float) -> Attributes {
        addingParagraphStyle(factor, keyPath: \.hyphenationFactor)
    }

    @available(iOS 15, macOS 13, watchOS 8, tvOS 15, *)
    func usesDefaultHyphenation(_ usesDefaultHyphenation: Bool) -> Attributes {
        addingParagraphStyle(usesDefaultHyphenation, keyPath: \.usesDefaultHyphenation)
    }

    func allowsDefaultTighteningForTruncation(_ isAllowed: Bool) -> Attributes {
        addingParagraphStyle(isAllowed, keyPath: \.allowsDefaultTighteningForTruncation)
    }

    func baseWritingDirection(_ direction: NSWritingDirection) -> Attributes {
        addingParagraphStyle(direction, keyPath: \.baseWritingDirection)
    }

    func tabStops(_ tabStops: [NSTextTab], defaultInterval: CGFloat = 0) -> Attributes {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.tabStops = tabStops
        paragraphStyle.defaultTabInterval = defaultInterval
        return addingAttribute(.paragraphStyle, value: paragraphStyle)
    }
}

// MARK: - All platforms but watchOS

#if !os(watchOS)
public extension Attributes {

    /// Set an attachment to the attributes.
    /// - Parameters:
    ///   - attachment: The text attachment that will be added to the attributes.
    /// - Returns:The modified attributes.
    func attachment(_ attachment: NSTextAttachment) -> Attributes {
        addingAttribute(.attachment, value: attachment)
    }
}
#endif

// MARK: - Internal Helper

extension Attributes {

    func addingParagraphStyle<T>(
        _ value: T,
        keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>
    ) -> Attributes {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle[keyPath: keyPath] = value
        return addingAttribute(.paragraphStyle, value: paragraphStyle)
    }
}
