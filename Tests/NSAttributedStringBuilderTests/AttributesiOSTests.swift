#if canImport(UIKit)
@testable import NSAttributedStringBuilder
import XCTest

final class AttributesiOSTests: XCTestCase {

    func testBoldWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.traitBold, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().bold()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testBoldWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let expectedFont = try AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.traitBold, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.bold()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testItalicWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.traitItalic, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().italic()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testItalicWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let expectedFont = try AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.traitItalic, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.italic()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testMonospacedWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.traitMonoSpace, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().monospaced()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testMonospacedWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let expectedFont = try AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.traitMonoSpace, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.monospaced()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testCondensedWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.traitCondensed, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().condensed()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testCondensedWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let expectedFont = try AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.traitCondensed, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.condensed()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    // MARK: - Accessibility

    func testAccessibilitySpeechLanguage() {
        // Given
        let language: NSAttributedStringBuilder.LanguageCode = .french
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilitySpeechLanguage: language.rawValue as NSString
        ]

        // When
        let result = attributes.accessibilitySpeechLanguage(language)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAccessibilitySpeechPunctuation() {
        // Given
        let isEnabled = Bool.random()
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilitySpeechPunctuation: NSNumber(value: isEnabled)
        ]

        // When
        let result = attributes.accessibilitySpeechPunctuation(isEnabled)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAccessibilitySpeechSpellOut() {
        // Given
        let isEnabled = Bool.random()
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilitySpeechSpellOut: NSNumber(value: isEnabled)
        ]

        // When
        let result = attributes.accessibilitySpeechSpellOut(isEnabled)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAccessibilitySpeechIPANotation() {
        // Given
        let phoneticString = "paɪˈɛlə" // Paella
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilitySpeechIPANotation: phoneticString as NSString
        ]

        // When
        let result = attributes.accessibilitySpeechIPANotation(phoneticString)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAccessibilitySpeechPitch() {
        // Given
        let pitch = 0.5
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilitySpeechPitch: NSNumber(value: pitch)
        ]

        // When
        let result = attributes.accessibilitySpeechPitch(pitch)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    // MARK: - All but watchOS

    #if !os(watchOS)
    func testSuperscriptWithDefaultValue() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            NSAttributedString.Key(kCTSuperscriptAttributeName as String): NSNumber(value: 1)
        ]

        // When
        let result = attributes.superscript()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testSuperscriptWithCustomValue() {
        // Given
        let subscripting = -1
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            NSAttributedString.Key(kCTSuperscriptAttributeName as String): NSNumber(value: subscripting)
        ]

        // When
        let result = attributes.superscript(subscripting)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }
    #endif
}
#endif
