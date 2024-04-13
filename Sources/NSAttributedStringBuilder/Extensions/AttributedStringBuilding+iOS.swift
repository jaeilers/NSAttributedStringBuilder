#if canImport(UIKit)
import UIKit

public extension AttributedStringBuilding {

    /// Returns a copy of the current font with the added trait. (e.g. bold, italic etc.)
    ///
    /// The default font is the standard dynamic type font with style `body`.
    /// - Parameters:
    ///   - trait: The trait that will be added to the current font traits.
    /// - Returns: A copy of the current font where the trait has been added.
    func fontWithTrait(_ trait: UIFontDescriptor.SymbolicTraits) -> UIFont {
        attributes()
            .fontWithTrait(trait)
    }
}

// MARK: - Accessibility

public extension AttributedStringBuilding {

    /// Set the language to use when speaking a string.
    ///
    /// Use this property for the attributed string in `accessibilityAttributedLabel`.
    /// - Parameters:
    ///   - language: The language to use for VoiceOver.
    /// - Returns: A copy of the modified attributed string.
    func accessibilitySpeechLanguage(_ language: NSAttributedStringBuilder.LanguageCode) -> NSAttributedString {
        addingAttributes(Attributes().accessibilitySpeechLanguage(language))
    }

    /// Set whether to speak punctuation or not.
    ///
    /// For example: "user.name" is spoken by VoiceOver as "user (pause) name".
    /// When this property is enabled, VoiceOver reads "user period name".
    /// Use this property for the attributed string in `accessibilityAttributedLabel`.
    /// - Parameters:
    ///   - isEnabled: A boolean value that indicates whether punctuation is spoken by VoiceOver or not.
    /// - Returns: A copy of the modified attributed string.
    func accessibilitySpeechPunctuation(_ isEnabled: Bool) -> NSAttributedString {
        addingAttributes(Attributes().accessibilitySpeechPunctuation(isEnabled))
    }

    /// Set a boolean value whether each letter should be spoken separately.
    ///
    /// Use this property for the attributed string in `accessibilityAttributedLabel`.
    /// - Parameters:
    ///   - isEnabled: A boolean value whether each letter should be spoken separately.
    /// - Returns: A copy of the modified attributed string.
    func accessibilitySpeechSpellOut(_ isEnabled: Bool) -> NSAttributedString {
        addingAttributes(Attributes().accessibilitySpeechSpellOut(isEnabled))
    }

    /// Set the pronunciation of a particular word or phrase in
    /// [International Phonetic Alphabet](https://en.wikipedia.org/wiki/International_Phonetic_Alphabet).
    ///
    /// Use this property for the attributed string in `accessibilityAttributedLabel`.
    /// - Parameters:
    ///   - phoneticString: The string in phonetic notation.
    /// - Returns: A copy of the modified attributed string.
    func accessibilitySpeechIPANotation(_ phoneticString: String) -> NSAttributedString {
        addingAttributes(Attributes().accessibilitySpeechIPANotation(phoneticString))
    }

    /// Apply a pitch to the spoken text.
    /// - Parameters:
    ///   - pitch: The value indicates whether to speak the text with a higher or lower pitch than the default.
    ///   The default value for this attribute is 1.0, which indicates a normal pitch. Values between 0.0 and 1.0
    ///   result in a lower pitch, and values between 1.0 and 2.0 result in a higher pitch.
    /// - Returns: A copy of the modified attributed string.
    func accessibilitySpeechPitch(_ pitch: Double) -> NSAttributedString {
        addingAttributes(Attributes().accessibilitySpeechPitch(pitch))
    }
}
#endif

// MARK: - All but watchOS

#if canImport(UIKit) && !os(watchOS)
public extension AttributedStringBuilding {

    /// Adds an image at the end of the attributed string.
    ///
    /// Existing attributes are added to the image.
    /// - Parameters:
    ///   - image: The image that will be added to the string.
    ///   - bounds: The bounds of the image. The bounds changes the default size
    ///   If no bounds are provided, then the default asset size is used. Default is `nil`.
    /// - Returns: A copy of the modified attributed string.
    func image(
        _ image: UIImage,
        bounds: CGRect? = nil
    ) -> NSAttributedString {
        let attachment = NSTextAttachment(image: image)
        bounds.map {
            attachment.bounds = $0
        }

        return addingAttributedString(NSAttributedString(attachment: attachment))
    }

    /// Adds an image at the end of the attributed string.
    ///
    /// Existing attributes are added to the image.
    /// - Parameters:
    ///   - systemName: The SF Symbol name (system name) of the image.
    ///   - bounds: The bounds of the image. The bounds changes the default size and placement of the image.
    ///   If no bounds are provided, then the default asset size is used. Default is `nil`.
    /// - Returns: A copy of the modified attributed string.
    func image(
        systemName: String,
        bounds: CGRect? = nil
    ) -> NSAttributedString {
        guard let img = UIImage(systemName: systemName) else {
            return attributedString()
        }

        return image(img, bounds: bounds)
    }

    /// Set the superscript of the text.
    /// - Parameters:
    ///   - value: The superscript value as an integer. Default text has a value of 0.
    ///   If supported by the specified font, a value of 1 enables superscripting
    ///   and a value of -1 enables subscripting. Default is `1`.
    /// - Returns: A copy of the current font where the trait has been added.
    func superscript(_ value: Int = 1) -> NSAttributedString {
        addingAttributes(Attributes().superscript(value))
    }
}
#endif
