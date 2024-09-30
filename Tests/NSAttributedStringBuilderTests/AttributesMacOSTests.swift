#if canImport(AppKit)
import AppKit
@testable import NSAttributedStringBuilder
import Testing

@Suite
struct AttributesMacOSTests {

    @Test
    func boldWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([.bold, font.fontDescriptor.symbolicTraits]))
        let expectedFont = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().bold()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func boldWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([.bold, font.fontDescriptor.symbolicTraits]))
        let expectedFont = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.bold()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func italicWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([.italic, font.fontDescriptor.symbolicTraits]))
        let expectedFont = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().italic()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func italicWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([.italic, font.fontDescriptor.symbolicTraits]))
        let expectedFont = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.italic()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func monospacedWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([.monoSpace, font.fontDescriptor.symbolicTraits]))
        let expectedFont = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().monospaced()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func monospacedWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([.monoSpace, font.fontDescriptor.symbolicTraits]))
        let expectedFont = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.monospaced()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func condensedWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([.condensed, font.fontDescriptor.symbolicTraits]))
        let expectedFont = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().condensed()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func condensedWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([.condensed, font.fontDescriptor.symbolicTraits]))
        let expectedFont = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.condensed()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func cursor() {
        // Given
        let cursor = NSCursor.crosshair
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .cursor: cursor
        ]

        // When
        let result = attributes.cursor(cursor)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func tighteningFactorForTruncation() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.alignment = .center
        newParagraphStyle.tighteningFactorForTruncation = 2.0
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .paragraphStyle: paragraphStyle
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .paragraphStyle: newParagraphStyle
        ]

        // When
        let result = attributes.tighteningFactorForTruncation(2.0)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func spellingStateWithSpellingErrors() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .spellingState: NSNumber(value: 1 << 0)
        ]

        // When
        let result = attributes.spellingState(.spellingErrors)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func spellingStateWithGrammarErrors() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .spellingState: NSNumber(value: 1 << 1)
        ]

        // When
        let result = attributes.spellingState(.grammarErrors)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func superscriptWithDefault() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .superscript: NSNumber(value: 1)
        ]

        // When
        let result = attributes.superscript()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func superscriptWithCustomValue() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .superscript: NSNumber(value: 3)
        ]

        // When
        let result = attributes.superscript(3)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func textAlternatives() throws {
        // Given
        let primaryString = String.unique()
        let alternativeString = [String.unique(), String.unique(), String.unique()]
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]

        // When
        let result = attributes.textAlternatives(
            primaryString: primaryString,
            alternativeStrings: alternativeString
        )

        // Then
        let resultTextAlternatives = try #require(result[.textAlternatives] as? NSTextAlternatives)
        #expect(resultTextAlternatives.primaryString == primaryString)
        #expect(resultTextAlternatives.alternativeStrings == alternativeString)
    }

    @Test
    func toolTip() {
        // Given
        let toolTipStr = String.unique()
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .toolTip: toolTipStr as NSString
        ]

        // When
        let result = attributes.toolTip(toolTipStr)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func glyphInfo() throws {
        // Given
        let baseString = "\u{FFFD}" // �
        let font = NSFont.preferredFont(forTextStyle: .body)
        let glyphInfo = try #require(NSGlyphInfo(cgGlyph: 2590, for: font, baseString: baseString))
        let attributes: Attributes = [
            .foregroundColor: AColor.orange
        ]
        let expected: Attributes = [
            .foregroundColor: AColor.orange,
            .font: font,
            .glyphInfo: glyphInfo
        ]

        // When
        let result = attributes.glyphInfo(glyphInfo)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func glyphInfoWithFont() throws {
        // Given
        let baseString = "\u{FFFD}" // �
        let font = NSFont.preferredFont(forTextStyle: .footnote)
        let glyphInfo = try #require(NSGlyphInfo(cgGlyph: 2590, for: font, baseString: baseString))
        let attributes: Attributes = [
            .foregroundColor: AColor.orange,
            .font: font
        ]
        let expected: Attributes = [
            .foregroundColor: AColor.orange,
            .font: font,
            .glyphInfo: glyphInfo
        ]

        // When
        let result = attributes.glyphInfo(glyphInfo)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func markedClauseSegment() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .markedClauseSegment: NSNumber(value: 1)
        ]

        // When
        let result = attributes.markedClauseSegment(1)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func headerLevel() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headerLevel = 3
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .paragraphStyle: paragraphStyle
        ]

        // When
        let result = attributes.headerLevel(3)

        // Then
        #expect(result.isEqual(to: expected))
    }

    // MARK: - Accessibility

    @Test
    func accessibilityAlignment() {
        // Given
        let alignment: NSTextAlignment = .center
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityAlignment: NSNumber(value: alignment.rawValue)
        ]

        // When
        let result = attributes.accessibilityAlignment(alignment)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func accessibilityAutocorrected() {
        // Given
        let isAutocorrected = Bool.random()
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityAutocorrected: NSNumber(value: isAutocorrected)
        ]

        // When
        let result = attributes.accessibilityAutocorrected(isAutocorrected)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func accessibilityForegroundColor() {
        // Given
        let color = AColor.yellow
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityForegroundColor: color.cgColor
        ]

        // When
        let result = attributes.accessibilityForegroundColor(color)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func accessibilityBackgroundColor() {
        // Given
        let color = AColor.blue
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityBackgroundColor: color.cgColor
        ]

        // When
        let result = attributes.accessibilityBackgroundColor(color)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func accessibilityLanguage() {
        // Given
        let language: NSAttributedStringBuilder.LanguageCode = .german
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityLanguage: language.rawValue as NSString
        ]

        // When
        let result = attributes.accessibilityLanguage(language)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func accessibilityMarkedMisspelled() {
        // Given
        let isMarked = Bool.random()
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityMarkedMisspelled: NSNumber(value: isMarked)
        ]

        // When
        let result = attributes.accessibilityMarkedMisspelled(isMarked)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func accessibilityShadow() {
        // Given
        let hasShadow = Bool.random()
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityShadow: NSNumber(value: hasShadow)
        ]

        // When
        let result = attributes.accessibilityShadow(hasShadow)

        // Then
        #expect(result.isEqual(to: expected))
    }
}
#endif
