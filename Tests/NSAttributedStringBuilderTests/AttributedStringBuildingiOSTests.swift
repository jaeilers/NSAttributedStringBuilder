#if canImport(UIKit)
import NSAttributedStringBuilder
import XCTest

final class AttributedStringBuildingiOSTests: XCTestCase {

    private let string = String.unique()

    // MARK: - Accessibility

    func testAccessibilitySpeechLanguageWithAttributedString() {
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
        XCTAssertEqual(result, expected)
    }

    func testAccessibilitySpeechLanguageWithString() {
        // Given
        let language: NSAttributedStringBuilder.LanguageCode = .vietnamese
        let attributes: Attributes = [
            .accessibilitySpeechLanguage: language.rawValue as NSString
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilitySpeechLanguage(language)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilitySpeechPunctuationWithAttributedString() {
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
        XCTAssertEqual(result, expected)
    }

    func testAccessibilitySpeechPunctuationWithString() {
        // Given
        let isEnabled = Bool.random()
        let attributes: Attributes = [
            .accessibilitySpeechPunctuation: NSNumber(value: isEnabled)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilitySpeechPunctuation(isEnabled)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilitySpeechSpellOutWithAttributedString() {
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
        XCTAssertEqual(result, expected)
    }

    func testAccessibilitySpeechSpellOutWithString() {
        // Given
        let isEnabled = Bool.random()
        let attributes: Attributes = [
            .accessibilitySpeechSpellOut: NSNumber(value: isEnabled)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilitySpeechSpellOut(isEnabled)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilitySpeechIPANotationWithAttributedString() {
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
        XCTAssertEqual(result, expected)
    }

    func testAccessibilitySpeechIPANotationWithString() {
        // Given
        let phoneticString = "paɪˈɛlə" // Paella
        let attributes: Attributes = [
            .accessibilitySpeechIPANotation: phoneticString as NSString
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilitySpeechIPANotation(phoneticString)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilitySpeechPitchWithAttributedString() {
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
        XCTAssertEqual(result, expected)
    }

    func testAccessibilitySpeechPitchWithString() {
        // Given
        let pitch = 1.5
        let attributes: Attributes = [
            .accessibilitySpeechPitch: NSNumber(value: pitch)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilitySpeechPitch(pitch)

        // Then
        XCTAssertEqual(result, expected)
    }

    // MARK: - All but watchOS

    #if !os(watchOS)
    func testUIImageWithAttributedString() throws {
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
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.image, image)
        XCTAssertEqual(resultAttributes[.font] as? UIFont, UIFont.preferredFont(forTextStyle: .body))
        XCTAssertEqual(resultAttributes[.foregroundColor] as? UIColor, UIColor.blue)
        XCTAssertEqual(resultAttributes[.kern] as? NSNumber, NSNumber(value: 1.0))

        let resultAttributedString = result.attributedSubstring(from: NSRange(location: 0, length: attributedString.length))
        XCTAssertEqual(resultAttributedString, attributedString)
    }

    func testUIImageWithAttributedStringAndSystemName() throws {
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
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertNotNil(resultAttachment.image)
        XCTAssertEqual(resultAttributes[.font] as? UIFont, UIFont.preferredFont(forTextStyle: .body))
        XCTAssertEqual(resultAttributes[.foregroundColor] as? UIColor, UIColor.orange)
        XCTAssertEqual(resultAttributes[.kern] as? NSNumber, NSNumber(value: 1.0))

        let resultAttributedString = result.attributedSubstring(from: NSRange(location: 0, length: attributedString.length))
        XCTAssertEqual(resultAttributedString, attributedString)
    }

    func testUIImageWithAttributedStringAndWrongSystemName() {
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
        XCTAssertEqual(result, attributedString)
    }

    func testSuperscriptWithDefaultValueAndAttributedString() {
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
        XCTAssertEqual(result, expected)
    }

    func testSuperscriptWithDefaultValueAndString() {
        // Given
        let attributes: Attributes = [
            NSAttributedString.Key(kCTSuperscriptAttributeName as String): NSNumber(value: 1)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.superscript()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSuperscriptWithCustomValueAndAttributedString() {
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
        XCTAssertEqual(result, expected)
    }

    func testSuperscriptWithCustomValueAndString() {
        // Given
        let subscripting = -1
        let attributes: Attributes = [
            NSAttributedString.Key(kCTSuperscriptAttributeName as String): NSNumber(value: subscripting)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.superscript(subscripting)

        // Then
        XCTAssertEqual(result, expected)
    }
    #endif
}
#endif
