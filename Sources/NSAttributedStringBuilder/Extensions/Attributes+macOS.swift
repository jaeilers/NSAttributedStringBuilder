#if canImport(AppKit)
import AppKit

public extension Attributes {

    /// Returns a copy of the current font with the added trait. (e.g. bold, italic etc.)
    ///
    /// The default font is the standard dynamic type font with style `body`.
    /// - Parameters:
    ///   - trait: The trait that will be added to the current font traits.
    /// - Returns: A copy of the current font where the trait has been added.
    func fontWithTrait(_ trait: NSFontDescriptor.SymbolicTraits) -> NSFont {
        let font: NSFont = attribute(.font) ?? NSFont.preferredFont(forTextStyle: .body)
        let descriptor = font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])

        return NSFont(descriptor: descriptor, size: 0.0) ?? font
    }

    /// Adds the bold trait to the current font.
    /// - Returns: The modified attributes.
    func bold() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.bold))
    }

    /// Adds the italic trait to the current font.
    /// - Returns: The modified attributes.
    func italic() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.italic))
    }

    /// Modifies the font of the text to use a fixed-width variant of the current font, if possible.
    /// - Returns: The modified attributes.
    func monospaced() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.monoSpace))
    }

    /// Adds the condensed trait to the current font.
    /// - Returns: The modified attributes.
    func condensed() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.condensed))
    }

    /// Set a cursor.
    /// - Parameters:
    ///   - cursor: The cursor.
    /// - Returns: The modified attributes.
    func cursor(_ cursor: NSCursor) -> Attributes {
        addingAttribute(.cursor, value: cursor)
    }

    /// Set the threshold for using tightening as an alternative to truncation.
    /// - Parameters:
    ///   - factor: The threshold as a floating point number.
    /// - Returns: The modified attributes.
    func tighteningFactorForTruncation(_ factor: Float) -> Attributes {
        addingParagraphStyle(factor, keyPath: \.tighteningFactorForTruncation)
    }

    /// Set the spelling state.
    /// - Parameters:
    ///   - state: The spelling state of the string.
    /// - Returns: The modified attributes.
    func spellingState(_ state: NSAttributedStringBuilder.SpellingState) -> Attributes {
        addingAttribute(.spellingState, value: state.rawValue)
    }

    /// Set the superscript of the text.
    /// - Parameters:
    ///   - value: The superscript value as an integer. Default is `1`.
    /// - Returns: The modified attributes.
    func superscript(_ value: Int = 1) -> Attributes {
        addingAttribute(.superscript, value: NSNumber(value: value))
    }

    /// Set the text alternatives.
    /// - Parameters:
    ///   - primaryString: The primary string of the text alternatives.
    ///   - alternativeStrings: The alternative strings.
    /// - Returns: The modified attributes.
    func textAlternatives(primaryString: String, alternativeStrings: [String]) -> Attributes {
        let textAlternatives = NSTextAlternatives(primaryString: primaryString, alternativeStrings: alternativeStrings)
        return addingAttribute(.textAlternatives, value: textAlternatives)
    }

    /// Set the tool tip for the attributed string.
    /// - Parameters:
    ///   - tip: The text to be displayed as tool tip.
    /// - Returns: The modified attributes.
    func toolTip(_ tip: String) -> Attributes {
        addingAttribute(.toolTip, value: tip as NSString)
    }

    /// The glyph info is assigned by the `NSLayoutManager` object.
    ///
    /// The specified glyph needs to be available in the font specified in `NSAttributedString.Key.font`.
    /// To replace a character use for example the replacement character (� U+FFFD) as a base string for `NSGlyphInfo`.
    /// All occurrences of the replacement character are replaced with the specified glyph.
    /// - Parameters:
    ///   - glyphInfo: The glyph info object to use by the layout manager. You need to specify a `font`
    ///   to use for the `glyphInfo`. If the attributed string does not have a font specified yet,
    ///   a default font will be set: `NSFont.preferredFont(forTextStyle: .body)`.
    /// - Returns: The modified attributes.
    func glyphInfo(_ glyphInfo: NSGlyphInfo) -> Attributes {
        var newAttributes: Attributes = [
            .glyphInfo: glyphInfo
        ]

        if (attribute(.font) as NSFont?) == nil {
            newAttributes[.font] = NSFont.preferredFont(forTextStyle: .body)
        }

        return addingAttributes(newAttributes)
    }

    /// Set the index of the marked clause segment.
    ///
    /// The value of this attribute contains an integer, as an index in marked text indicating clause segments.
    /// - Parameters:
    ///   - segmentIndex: The index of the marked clause segment.
    /// - Returns: The modified attributes.
    func markedClauseSegment(_ segmentIndex: Int) -> Attributes {
        addingAttribute(.markedClauseSegment, value: NSNumber(value: segmentIndex))
    }

    /// Set the paragraph’s header level for HTML generation.
    /// - Parameters:
    ///   - headerLevel: The header level as an integer value. If the paragraph is a header,
    ///   the value ranges from 1 to 6 depending on the header's level.
    /// - Returns: The modified attributes.
    func headerLevel(_ headerLevel: Int) -> Attributes {
        addingParagraphStyle(headerLevel, keyPath: \.headerLevel)
    }
}

// MARK: - Accessibility

public extension Attributes {

    /// Set the accessibility alignment of the text.
    /// - Parameters:
    ///   - alignment: The alignment of the text.
    /// - Returns: The modified attributes.
    func accessibilityAlignment(_ alignment: NSTextAlignment) -> Attributes {
        addingAttribute(.accessibilityAlignment, value: NSNumber(value: alignment.rawValue))
    }

    /// Set autocorrection for the text.
    /// - Parameters:
    ///   - isAutocorrected: A boolean value that indicates whether the text is autocorrected.
    /// - Returns: The modified attributes.
    func accessibilityAutocorrected(_ isAutocorrected: Bool) -> Attributes {
        addingAttribute(.accessibilityAutocorrected, value: NSNumber(value: isAutocorrected))
    }

    /// Set the accessibility foreground color.
    /// - Parameters:
    ///   - color: The accessibility foreground color.
    /// - Returns: The modified attributes.
    func accessibilityForegroundColor(_ color: NSColor) -> Attributes {
        addingAttribute(.accessibilityForegroundColor, value: color.cgColor)
    }

    /// Set the accessibility background color.
    /// - Parameters:
    ///   - color: The accessibility background color.
    /// - Returns: The modified attributes.
    func accessibilityBackgroundColor(_ color: NSColor) -> Attributes {
        addingAttribute(.accessibilityBackgroundColor, value: color.cgColor)
    }

    /// The language of the text for VoiceOver.
    /// - Parameters:
    ///   - language: The language of the text for accessibility.
    /// - Returns: The modified attributes.
    func accessibilityLanguage(_ language: NSAttributedStringBuilder.LanguageCode) -> Attributes {
        addingAttribute(.accessibilityLanguage, value: language.rawValue as NSString)
    }

    /// Mark misspelled text for VoiceOver.
    /// - Parameters:
    ///   - isMisspelled: A boolean value that indicates whether the text is misspelled.
    /// - Returns: The modified attributes.
    func accessibilityMarkedMisspelled(_ isMisspelled: Bool) -> Attributes {
        addingAttribute(.accessibilityMarkedMisspelled, value: NSNumber(value: isMisspelled))
    }

    /// Set the accessibility text shadow.
    /// - Parameters:
    ///   - hasShadow: A boolean value that indicates whether the text has a shadow for accessibility.
    /// - Returns: The modified attributes.
    func accessibilityShadow(_ hasShadow: Bool) -> Attributes {
        addingAttribute(.accessibilityShadow, value: NSNumber(value: hasShadow))
    }
}
#endif
