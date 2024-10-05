#if canImport(UIKit)
import UIKit
@testable import NSAttributedStringBuilder
import Testing

@Suite
struct AttributesiOSTests {

    @Test("Apply bold with and without existing font", arguments: [nil, AFont.preferredFont(forTextStyle: .headline)])
    func bold(with existingFont: AFont?) throws {
        // Given
        let font = existingFont ?? AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try AFont(
            descriptor: #require(font.fontDescriptor.withSymbolicTraits([.traitBold, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let expected: Attributes = [
            .font: expectedFont
        ]

        var attributes = Attributes()
        existingFont.map {
            attributes[.font] = $0
        }

        // When
        let result = attributes.bold()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test("Apply italic with and without existing font", arguments: [nil, AFont.preferredFont(forTextStyle: .headline)])
    func italic(with existingFont: AFont?) throws {
        // Given
        let font = existingFont ?? AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try AFont(
            descriptor: #require(font.fontDescriptor.withSymbolicTraits([.traitItalic, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let expected: Attributes = [
            .font: expectedFont
        ]

        var attributes = Attributes()
        existingFont.map {
            attributes[.font] = $0
        }

        // When
        let result = attributes.italic()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test("Apply monospace with and without existing font", arguments: [nil, AFont.preferredFont(forTextStyle: .headline)])
    func monospaced(with existingFont: AFont?) throws {
        // Given
        let font = existingFont ?? AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try AFont(
            descriptor: #require(font.fontDescriptor.withSymbolicTraits([.traitMonoSpace, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let expected: Attributes = [
            .font: expectedFont
        ]

        var attributes = Attributes()
        existingFont.map {
            attributes[.font] = $0
        }

        // When
        let result = attributes.monospaced()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test("Apply condensed with and without existing font", arguments: [nil, AFont.preferredFont(forTextStyle: .headline)])
    func condensed(with existingFont: AFont?) throws {
        // Given
        let font = existingFont ?? AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try AFont(
            descriptor: #require(font.fontDescriptor.withSymbolicTraits([.traitCondensed, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let expected: Attributes = [
            .font: expectedFont
        ]

        var attributes = Attributes()
        existingFont.map {
            attributes[.font] = $0
        }

        // When
        let result = attributes.condensed()

        // Then
        #expect(result.isEqual(to: expected))
    }

    // MARK: - Accessibility

    @Test
    func accessibilitySpeechLanguage() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func accessibilitySpeechPunctuation() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func accessibilitySpeechSpellOut() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func accessibilitySpeechIPANotation() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func accessibilitySpeechPitch() {
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
        #expect(result.isEqual(to: expected))
    }

    // MARK: - All but watchOS

    #if !os(watchOS)
    @Test
    func superscriptWithDefaultValue() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func superscriptWithCustomValue() {
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
        #expect(result.isEqual(to: expected))
    }
    #endif
}
#endif
