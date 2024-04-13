#if canImport(AppKit)
@testable import NSAttributedStringBuilder
import XCTest

final class AttributesMacOSTests: XCTestCase {

    func testBoldWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.bold, font.fontDescriptor.symbolicTraits])),
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
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.bold, font.fontDescriptor.symbolicTraits])),
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testItalicWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.italic, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
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
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.italic, font.fontDescriptor.symbolicTraits])),
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testMonospacedWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.monoSpace, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
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
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.monoSpace, font.fontDescriptor.symbolicTraits])),
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testCondensedWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.condensed, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
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
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.condensed, font.fontDescriptor.symbolicTraits])),
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testCursor() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testTighteningFactorForTruncation() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testSpellingStateWithSpellingErrors() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testSpellingStateWithGrammarErrors() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testSuperscriptWithDefault() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testSuperscriptWithCustomValue() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testTextAlternatives() throws {
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
        let resultTextAlternatives = try XCTUnwrap(result[.textAlternatives] as? NSTextAlternatives)
        XCTAssertEqual(resultTextAlternatives.primaryString, primaryString)
        XCTAssertEqual(resultTextAlternatives.alternativeStrings, alternativeString)
    }

    func testToolTip() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testGlyphInfo() throws {
        // Given
        let baseString = "\u{FFFD}" // �
        let font = NSFont.preferredFont(forTextStyle: .body)
        let glyphInfo = try XCTUnwrap(NSGlyphInfo(cgGlyph: 2590, for: font, baseString: baseString))
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testGlyphInfoWithFont() throws {
        // Given
        let baseString = "\u{FFFD}" // �
        let font = NSFont.preferredFont(forTextStyle: .footnote)
        let glyphInfo = try XCTUnwrap(NSGlyphInfo(cgGlyph: 2590, for: font, baseString: baseString))
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testMarkedClauseSegment() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testHeaderLevel() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    // MARK: - Accessibility

    func testAccessibilityAlignment() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAccessibilityAutocorrected() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAccessibilityForegroundColor() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAccessibilityBackgroundColor() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAccessibilityLanguage() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAccessibilityMarkedMisspelled() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAccessibilityShadow() {
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
        XCTAssertTrue(result.isEqual(to: expected))
    }
}
#endif
