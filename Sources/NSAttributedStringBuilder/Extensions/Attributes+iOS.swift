#if canImport(UIKit)
import UIKit

public extension Attributes {

    /// Returns a copy of the current font with the added trait. (e.g. bold, italic etc.)
    ///
    /// The default font is the standard dynamic type font with style `body`.
    /// - Parameters:
    ///   - trait: The trait that will be added to the current font traits.
    /// - Returns: A copy of the current font where the trait has been added.
    func fontWithTrait(_ trait: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let font: UIFont = attribute(.font) ?? UIFont.preferredFont(forTextStyle: .body)

        guard let descriptor = font.fontDescriptor.withSymbolicTraits(
            [trait, font.fontDescriptor.symbolicTraits]
        ) else {
            return font
        }

        return UIFont(descriptor: descriptor, size: 0.0)
    }

    /// Adds the bold trait to the current font.
    /// - Returns: The modified attributes.
    func bold() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.traitBold))
    }

    /// Adds the italic trait to the current font.
    /// - Returns: The modified attributes.
    func italic() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.traitItalic))
    }

    /// Modifies the font of the text to use a fixed-width variant of the current font, if possible.
    /// - Returns: The modified attributes.
    func monospaced() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.traitMonoSpace))
    }

    /// Adds the condensed trait to the current font.
    /// - Returns: The modified attributes.
    func condensed() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.traitCondensed))
    }
}

// MARK: - Accessibility

public extension Attributes {

    /// Set the language to use when speaking the text.
    ///
    /// Use this property for the attributed string in `accessibilityAttributedLabel`.
    /// - Parameters:
    ///   - language: The language to use for VoiceOver.
    /// - Returns: The modified attributes.
    func accessibilitySpeechLanguage(_ language: NSAttributedStringBuilder.LanguageCode) -> Attributes {
        addingAttribute(.accessibilitySpeechLanguage, value: language.rawValue as NSString)
    }

    /// Set whether to speak punctuation or not.
    ///
    /// For example: "user.name" is spoken by VoiceOver as "user (pause) name".
    /// When this property is enabled, VoiceOver reads "user period name".
    /// Use this property for the attributed string in `accessibilityAttributedLabel`.
    /// - Parameters:
    ///   - isEnabled: A boolean value that indicates whether punctuation is spoken by VoiceOver or not.
    /// - Returns: The modified attributes.
    func accessibilitySpeechPunctuation(_ isEnabled: Bool) -> Attributes {
        addingAttribute(.accessibilitySpeechPunctuation, value: NSNumber(value: isEnabled))
    }

    /// Set a boolean value whether each letter should be spoken separately.
    ///
    /// Use this property for the attributed string in `accessibilityAttributedLabel`.
    /// - Parameters:
    ///   - isEnabled: A boolean value whether each letter should be spoken separately.
    /// - Returns: The modified attributes.
    func accessibilitySpeechSpellOut(_ isEnabled: Bool) -> Attributes {
        addingAttribute(.accessibilitySpeechSpellOut, value: NSNumber(value: isEnabled))
    }

    /// Set the pronunciation of a particular word or phrase in
    /// [International Phonetic Alphabet](https://en.wikipedia.org/wiki/International_Phonetic_Alphabet).
    ///
    /// Use this property for the attributed string in `accessibilityAttributedLabel`.
    /// - Parameters:
    ///   - phoneticString: The string in phonetic notation.
    /// - Returns: The modified attributes.
    func accessibilitySpeechIPANotation(_ phoneticString: String) -> Attributes {
        addingAttribute(.accessibilitySpeechIPANotation, value: phoneticString as NSString)
    }

    /// Apply a pitch to the spoken text.
    ///
    /// Use this property for the attributed string in `accessibilityAttributedLabel`.
    /// - Parameters:
    ///   - pitch: The value indicates whether to speak the text with a higher or lower pitch than the default.
    ///   The default value for this attribute is 1.0, which indicates a normal pitch. Values between 0.0 and 1.0
    ///   result in a lower pitch, and values between 1.0 and 2.0 result in a higher pitch.
    /// - Returns: The modified attributes.
    func accessibilitySpeechPitch(_ pitch: Double) -> Attributes {
        addingAttribute(.accessibilitySpeechPitch, value: NSNumber(value: pitch))
    }
}
#endif

// MARK: - All but watchOS

#if canImport(UIKit) && !os(watchOS)
public extension Attributes {

    /// Set the superscript of the text.
    /// - Parameters:
    ///   - value: The superscript value as an integer. Default text has a value of 0.
    ///   If supported by the specified font, a value of 1 enables superscripting
    ///   and a value of -1 enables subscripting. Default is `1`.
    /// - Returns: The modified attributes.
    func superscript(_ value: Int = 1) -> Attributes {
        addingAttribute(NSAttributedString.Key(kCTSuperscriptAttributeName as String), value: NSNumber(value: value))
    }
}
#endif
