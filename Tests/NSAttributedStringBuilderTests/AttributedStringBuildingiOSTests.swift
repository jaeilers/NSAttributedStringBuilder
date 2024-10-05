#if canImport(UIKit)
import NSAttributedStringBuilder
import UIKit
import Testing

@Suite
struct AttributedStringBuildingiOSTests {

    private let string = String.unique()

    // MARK: - Accessibility

    @Test
    func accessibilitySpeechLanguageWithAttributedString() {
        // Given
        let language: NSAttributedStringBuilder.LanguageCode = .vietnamese
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilitySpeechLanguage: language.rawValue as NSString
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilitySpeechLanguage(language)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilitySpeechLanguageWithString() {
        // Given
        let language: NSAttributedStringBuilder.LanguageCode = .vietnamese
        let attributes: Attributes = [
            .accessibilitySpeechLanguage: language.rawValue as NSString
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilitySpeechLanguage(language)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilitySpeechPunctuationWithAttributedString() {
        // Given
        let isEnabled = Bool.random()
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilitySpeechPunctuation: NSNumber(value: isEnabled)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilitySpeechPunctuation(isEnabled)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilitySpeechPunctuationWithString() {
        // Given
        let isEnabled = Bool.random()
        let attributes: Attributes = [
            .accessibilitySpeechPunctuation: NSNumber(value: isEnabled)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilitySpeechPunctuation(isEnabled)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilitySpeechSpellOutWithAttributedString() {
        // Given
        let isEnabled = Bool.random()
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilitySpeechSpellOut: NSNumber(value: isEnabled)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilitySpeechSpellOut(isEnabled)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilitySpeechSpellOutWithString() {
        // Given
        let isEnabled = Bool.random()
        let attributes: Attributes = [
            .accessibilitySpeechSpellOut: NSNumber(value: isEnabled)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilitySpeechSpellOut(isEnabled)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilitySpeechIPANotationWithAttributedString() {
        // Given
        let phoneticString = "paɪˈɛlə" // Paella
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilitySpeechIPANotation: phoneticString as NSString
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilitySpeechIPANotation(phoneticString)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilitySpeechIPANotationWithString() {
        // Given
        let phoneticString = "paɪˈɛlə" // Paella
        let attributes: Attributes = [
            .accessibilitySpeechIPANotation: phoneticString as NSString
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilitySpeechIPANotation(phoneticString)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilitySpeechPitchWithAttributedString() {
        // Given
        let pitch = 1.5
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilitySpeechPitch: NSNumber(value: pitch)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilitySpeechPitch(pitch)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilitySpeechPitchWithString() {
        // Given
        let pitch = 1.5
        let attributes: Attributes = [
            .accessibilitySpeechPitch: NSNumber(value: pitch)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilitySpeechPitch(pitch)

        // Then
        #expect(result == expected)
    }

    // MARK: - All but watchOS

    #if !os(watchOS)
    @Test
    func imageWithAttributedString() throws {
        // Given
        let attributes: Attributes = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.blue,
            .kern: NSNumber(value: 1.0)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let bounds = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        let image = try UIImage.pencil()

        // When
        let result = attributedString.image(image, bounds: bounds)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image == image)
        #expect(resultAttributes[.font] as? UIFont == UIFont.preferredFont(forTextStyle: .body))
        #expect(resultAttributes[.foregroundColor] as? UIColor == UIColor.blue)
        #expect(resultAttributes[.kern] as? NSNumber == NSNumber(value: 1.0))

        let resultAttributedString = result.attributedSubstring(from: NSRange(location: 0, length: attributedString.length))
        #expect(resultAttributedString == attributedString)
    }

    @Test
    func imageWithAttributedStringAndSystemName() throws {
        // Given
        let attributes: Attributes = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.orange,
            .kern: NSNumber(value: 1.0)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let bounds = CGRect(origin: .zero, size: .init(width: 1, height: 1))

        // When
        let result = attributedString.image(systemName: "pencil", bounds: bounds)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image != nil)
        #expect(resultAttributes[.font] as? UIFont == UIFont.preferredFont(forTextStyle: .body))
        #expect(resultAttributes[.foregroundColor] as? UIColor == UIColor.orange)
        #expect(resultAttributes[.kern] as? NSNumber == NSNumber(value: 1.0))

        let resultAttributedString = result.attributedSubstring(from: NSRange(location: 0, length: attributedString.length))
        #expect(resultAttributedString == attributedString)
    }

    @Test
    func imageWithAttributedStringAndWrongSystemName() {
        // Given
        let attributedString = NSAttributedString(
            string: string, attributes: [
                .font: UIFont.preferredFont(forTextStyle: .callout),
                .backgroundColor: UIColor.yellow,
                .baselineOffset: NSNumber(value: 1)
            ]
        )

        // When
        let result = attributedString.image(systemName: .unique())

        // Then
        #expect(result == attributedString)
    }

    @Test
    func superscriptWithDefaultValueAndAttributedString() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            NSAttributedString.Key(kCTSuperscriptAttributeName as String): NSNumber(value: 1)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.superscript()

        // Then
        #expect(result == expected)
    }

    @Test
    func superscriptWithDefaultValueAndString() {
        // Given
        let attributes: Attributes = [
            NSAttributedString.Key(kCTSuperscriptAttributeName as String): NSNumber(value: 1)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.superscript()

        // Then
        #expect(result == expected)
    }

    @Test
    func superscriptWithCustomValueAndAttributedString() {
        // Given
        let subscripting = -1
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            NSAttributedString.Key(kCTSuperscriptAttributeName as String): NSNumber(value: subscripting)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.superscript(subscripting)

        // Then
        #expect(result == expected)
    }

    @Test
    func superscriptWithCustomValueAndString() {
        // Given
        let subscripting = -1
        let attributes: Attributes = [
            NSAttributedString.Key(kCTSuperscriptAttributeName as String): NSNumber(value: subscripting)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.superscript(subscripting)

        // Then
        #expect(result == expected)
    }
    #endif
}
#endif
