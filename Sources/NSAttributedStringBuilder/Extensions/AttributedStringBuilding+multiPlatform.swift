#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension AttributedStringBuilding {

    /// Get the attribute of the last character.
    /// - Parameters:
    ///   - key: The key of the attribute.
    /// - Returns: The current attribute for a given key.
    func attribute<T>(_ key: NSAttributedString.Key) -> T? {
        attributes()
            .attribute(key)
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
    /// - Returns: A copy of the modified attributed string.
    func addingAttribute(_ name: NSAttributedString.Key, value: Any) -> NSAttributedString {
        addingAttributes([name: value])
    }

    /// Get the mutable paragraph style of the last character. If none exist, a new paragraph style is created.
    /// - Returns: A copy of the current paragraph style.
    func mutableParagraphStyle() -> NSMutableParagraphStyle {
        attributes()
            .mutableParagraphStyle()
    }

    /// Appends a string to the existing attributed string. Existing attributes are added to the appended string.
    /// - Parameters:
    ///   - newString: The string that will be appended.
    /// - Returns: A copy of the modified attributed string.
    func addingString(_ newString: String) -> NSAttributedString {
        addingAttributedString(NSAttributedString(string: newString))
    }

    /// Adds a string to the current context.
    ///
    /// The existing attributes are applied to the string.
    /// - Parameters:
    ///   - newString: The string will be appended to the current string.
    /// - Returns: A copy of the modified attributed string.
    func text(_ newString: String) -> NSAttributedString {
        addingString(newString)
    }

    /// Set the kerning of the text.
    /// - Parameters:
    ///   - kerning: The text kerning. A kerning of 0 means it is disabled.
    /// - Returns: A copy of the modified attributed string.
    func kerning(_ kerning: Double) -> NSAttributedString {
        addingAttributes(Attributes().kerning(kerning))
    }

    /// Adds a spacing at the end of the attributed string.
    /// - Parameters:
    ///   - spacing: The type of `Spacing`. Default is `.standard` whitespace.
    /// - Returns: A copy of the modified attributed string.
    func space(_ spacing: Spacing = .standard) -> NSAttributedString {
        switch spacing {
        case .standard:
            return addingString("\u{0020}")
        case .enSpace:
            return addingString("\u{2002}")
        case .emSpace:
            return addingString("\u{2003}")
        case .nonBreakingSpace:
            return addingString("\u{00A0}")
        case .narrowNonBreakingSpace:
            return addingString("\u{202F}")
        #if !os(watchOS)
        case let .custom(width):
            let attachment = NSTextAttachment()
            attachment.bounds = .init(origin: .zero, size: .init(width: width, height: 0.001))
            return addingAttributedString(NSAttributedString(attachment: attachment))
        #endif
        }
    }

    /// Adds a non-breaking space at the end of the attributed string.
    /// - Returns: A copy of the modified attributed string.
    func nonBreakingSpace() -> NSAttributedString {
        space(.nonBreakingSpace)
    }

    /// Adds a newline at the end of the attributed string.
    /// - Returns: A copy of the modified attributed string.
    func newline() -> NSAttributedString {
        addingString("\n")
    }

    /// Set a link with url to the attributed string.
    /// - Parameters:
    ///   - url: The url for the link attribute.
    /// - Returns: A copy of the modified attributed string.
    func link(_ url: URL) -> NSAttributedString {
        addingAttributes(Attributes().link(url))
    }

    /// Set the baseline offset for the attributed string.
    /// - Parameters:
    ///   - offset: The baseline offset.
    /// - Returns: A copy of the modified attributed string.
    func baselineOffset(_ offset: Double) -> NSAttributedString {
        addingAttributes(Attributes().baselineOffset(offset))
    }

    /// Set the ligature option for the attributed string.
    /// - Parameters:
    ///   - option: The ligature option. The font must support ligatures.
    /// - Returns: A copy of the modified attributed string.
    func ligature(_ option: Ligature) -> NSAttributedString {
        addingAttributes(Attributes().ligature(option))
    }

    /// Set the text effect for attributed string.
    /// - Parameters:
    ///   - style: The text effect style.
    /// - Returns: A copy of the modified attributed string.
    func textEffect(_ style: NSAttributedString.TextEffectStyle) -> NSAttributedString {
        addingAttributes(Attributes().textEffect(style))
    }

    /// Set the writing direction for the attributed string.
    /// - Parameters:
    ///   - direction: The direction options for string. See `WritingDirection` for options.
    /// - Returns: A copy of the modified attributed string.
    func writingDirection(_ direction: NSAttributedStringBuilder.WritingDirection) -> NSAttributedString {
        addingAttributes(Attributes().writingDirection(direction))
    }

    /// Set the language of the text.
    ///
    /// This provides a backport for the key `.languageIdentifier`.
    /// When this attribute is set, it will be used to select localized glyphs (if supported by the font),
    /// and locale-specific line-breaking rules.
    /// - Parameters:
    ///   - languageCode: The language code of the language.
    /// - Returns: A copy of the modified attributed string.
    func language(_ languageCode: NSAttributedStringBuilder.LanguageCode) -> NSAttributedString {
        addingAttributes(Attributes().language(languageCode))
    }

    /// Set the language identifier of the text.
    ///
    /// The language identifier will be used for locale-specific line-breaking rules.
    /// - Parameters:
    ///   - languageCode: The language code identifier.
    /// - Returns: A copy of the modified attributed string.
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    func languageIdentifier(_ languageCode: Locale.LanguageCode) -> NSAttributedString {
        addingAttributes(Attributes().languageIdentifier(languageCode))
    }

    /// Set the tracking of the text.
    ///
    /// 'Tracking' is similar to kerning that it changes the spacing between the letters,
    /// but kerning tries to keep ligatures where tracking does not. If you set tracking and kerning at the same time
    /// then tracking overrides kerning. Both cannot be used a the same time.
    /// - Parameters:
    ///   - tracking: The tracking changes the spacing between the letters. A tracking of 0 means it is disabled.
    /// - Returns: A copy of the modified attributed string.
    @available(iOS 14, tvOS 14, watchOS 7, *)
    func tracking(_ tracking: Double) -> NSAttributedString {
        addingAttributes(Attributes().tracking(tracking))
    }
}

// MARK: - Platform dependent (typealias)

public extension AttributedStringBuilding {

    /// Set the font of the attributed string.
    /// - Parameters:
    ///   - font: The platform dependent font.
    /// - Returns: A copy of the modified attributed string.
    func font(_ font: AFont) -> NSAttributedString {
        addingAttributes(Attributes().font(font))
    }

    /// Set the foreground color of the text and images.
    /// - Parameters:
    ///   - color: The new color of the text and images.
    /// - Returns: A copy of the modified attributed string.
    func foregroundColor(_ color: AColor) -> NSAttributedString {
        addingAttributes(Attributes().foregroundColor(color))
    }

    /// Set the background color of the attributed string.
    /// - Parameters:
    ///   - color: The new background color.
    /// - Returns: A copy of the modified attributed string.
    func backgroundColor(_ color: AColor) -> NSAttributedString {
        addingAttributes(Attributes().backgroundColor(color))
    }

    /// Set the underline style of the text.
    /// - Parameters:
    ///   - style: The underline style of the text. Default is `single`.
    ///   - color: The color of the underline. The `foregroundColor` is used when no color is set. Default is `nil`.
    /// - Returns: A copy of the modified attributed string.
    func underline(_ style: NSUnderlineStyle = .single, color: AColor? = nil) -> NSAttributedString {
        let newAttributes = attributes()
            .underline(style, color: color)

        return addingAttributes(newAttributes)
    }

    /// Set the strike through style of the text.
    /// - Parameters:
    ///   - style: The strike through style of the text. Default is `single`.
    ///   - color: The color of the strike through. The `foregroundColor` is used when no color is set.
    ///   Default is `nil`.
    /// - Returns: A copy of the modified attributed string.
    func strikethrough(_ style: NSUnderlineStyle = .single, color: AColor? = nil) -> NSAttributedString {
        let newAttributes = attributes()
            .strikethrough(style, color: color)

        return addingAttributes(newAttributes)
    }

    /// Set the shadow style of the text.
    /// - Parameters:
    ///   - offset: The offset of the shadow. Default is `width: 1` and `height: 1`.
    ///   - blurRadius: The blur radius of the shadow. Default is `5.0`.
    ///   - color: The color of the shadow. Default is `nil` which results in `black` with an alpha value of 1/3.
    /// - Returns: A copy of the modified attributed string.
    func shadow(
        offset: CGSize = .init(width: 1, height: 1),
        blurRadius: Double = 5.0,
        color: AColor? = nil
    ) -> NSAttributedString {
        let newAttributes = attributes()
            .shadow(offset: offset, blurRadius: blurRadius, color: color)

        return addingAttributes(newAttributes)
    }

    /// Set the stroke around the glyphs of the text.
    /// - Parameters:
    ///   - width: The width of the stroke.
    ///   Value is `>0`: Stroke border line without fill,
    ///   value is `0`: Fill content only and
    ///   value is `<0`:  Both stroke and border line and fill content.
    ///   Default is `2.0`.
    ///   - color: The color of the stroke. When no color is set, the `foregroundColor` is used. Default is `nil`.
    /// - Returns: A copy of the modified attributed string.
    func stroke(width: Double = 2.0, color: AColor? = nil) -> NSAttributedString {
        let newAttributes = attributes()
            .stroke(width: width, color: color)

        return addingAttributes(newAttributes)
    }
}

// MARK: - UIKit/AppKit

#if canImport(AppKit) || canImport(UIKit)
public extension AttributedStringBuilding {

    /// Adds the bold trait to the current font.
    /// - Returns: A copy of the modified attributed string.
    func bold() -> NSAttributedString {
        addingAttributes(attributes().bold())
    }

    /// Adds the italic trait to the current font.
    /// - Returns: A copy of the modified attributed string.
    func italic() -> NSAttributedString {
        addingAttributes(attributes().italic())
    }

    /// Modifies the font of the text to use a fixed-width variant of the current font, if possible.
    /// - Returns: A copy of the modified attributed string.
    func monospaced() -> NSAttributedString {
        addingAttributes(attributes().monospaced())
    }

    /// Adds the condensed trait to the current font.
    /// - Returns: A copy of the modified attributed string.
    func condensed() -> NSAttributedString {
        addingAttributes(attributes().condensed())
    }
}
#endif

// MARK: - All platforms but watchOS

#if !os(watchOS)
public extension AttributedStringBuilding {

    /// Adds an attachment to the whole string.
    /// - Parameters:
    ///   - attachment: The text attachment that will be added to the attributed string.
    /// - Returns: A copy of the modified attributed string.
    func attachment(_ attachment: NSTextAttachment) -> NSAttributedString {
        addingAttributes(Attributes().attachment(attachment))
    }
}
#endif
