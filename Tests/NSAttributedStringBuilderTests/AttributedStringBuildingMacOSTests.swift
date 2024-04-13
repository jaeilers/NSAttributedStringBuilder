#if canImport(AppKit)
import NSAttributedStringBuilder
import XCTest

final class AttributedStringBuildingMacOSTests: XCTestCase {

    private let string = String.unique()

    func testNSImageWithAttributedString() throws {
        // Given
        let attributes: Attributes = [
            .font: NSFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: NSColor.textColor,
            .kern: NSNumber(value: 1.0)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)

        let bounds = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        let accessibilityDescription = String.unique()
        let image = try NSImage.pencil()
        image.accessibilityDescription = accessibilityDescription

        let attachment = NSTextAttachment()
        attachment.image = image

        let expected = NSMutableAttributedString()
        expected.append(attributedString)
        expected.append(NSAttributedString(attachment: attachment))
        expected.addAttributes(attributes, range: NSRange(location: 0, length: expected.length))

        // When
        let result = try attributedString.image(NSImage.pencil(), bounds: bounds, accessibilityDescription: accessibilityDescription)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertNotNil(resultAttachment.image)
        XCTAssertEqual(resultAttachment.image?.accessibilityDescription, accessibilityDescription)
        XCTAssertEqual(resultAttachment.bounds, bounds)
        XCTAssertEqual(resultAttributes[.font] as? NSFont, NSFont.preferredFont(forTextStyle: .headline))
        XCTAssertEqual(resultAttributes[.foregroundColor] as? NSColor, NSColor.textColor)
        XCTAssertEqual(resultAttributes[.kern] as? NSNumber, NSNumber(value: 1.0))

        let resultAttributedString = result.attributedSubstring(from: NSRange(location: 0, length: attributedString.length))
        XCTAssertEqual(resultAttributedString, attributedString)
    }

    func testNSImageWithAttributedStringAndSystemName() throws {
        // Given
        let attributes: Attributes = [
            .font: NSFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: NSColor.textColor,
            .kern: NSNumber(value: 1.0)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)

        let bounds = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        let accessibilityDescription = String.unique()
        let image = try NSImage.pencil()
        image.accessibilityDescription = accessibilityDescription

        let attachment = NSTextAttachment()
        attachment.image = image

        let expected = NSMutableAttributedString()
        expected.append(attributedString)
        expected.append(NSAttributedString(attachment: attachment))
        expected.addAttributes(attributes, range: NSRange(location: 0, length: expected.length))

        // When
        let result = attributedString.image(systemName: "pencil", bounds: bounds, accessibilityDescription: accessibilityDescription)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertNotNil(resultAttachment.image)
        XCTAssertEqual(resultAttachment.image?.accessibilityDescription, accessibilityDescription)
        XCTAssertEqual(resultAttachment.bounds, bounds)
        XCTAssertEqual(resultAttributes[.font] as? NSFont, NSFont.preferredFont(forTextStyle: .headline))
        XCTAssertEqual(resultAttributes[.foregroundColor] as? NSColor, NSColor.textColor)
        XCTAssertEqual(resultAttributes[.kern] as? NSNumber, NSNumber(value: 1.0))

        let resultAttributedString = result.attributedSubstring(from: NSRange(location: 0, length: attributedString.length))
        XCTAssertEqual(resultAttributedString, attributedString)
    }

    func testNSImageWithAttributedStringAndSystemNameIsUnknown() {
        // Given
        let attributedString = NSAttributedString(string: string)

        // When
        let result = attributedString.image(systemName: .unique())

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        XCTAssertNil(resultAttributes[.attachment] as? NSTextAttachment)
    }

    func testCursorWithAttributedString() throws {
        // Given
        let cursor = NSCursor.pointingHand
        let attributes: Attributes = [
            .font: NSFont.preferredFont(forTextStyle: .footnote)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newAttributes = attributes.merging([.cursor: cursor], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.cursor(cursor)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testCursorWithString() throws {
        // Given
        let cursor = NSCursor.arrow
        let expected = NSAttributedString(string: string, attributes: [.cursor: cursor])

        // When
        let result = string.cursor(cursor)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testTighteningFactorForTruncationWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 2.0
        paragraphStyle.tighteningFactorForTruncation = 1.0
        let attributedString = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.hyphenationFactor = 2.0
        newParagraphStyle.tighteningFactorForTruncation = 5.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: newParagraphStyle])

        // When
        let result = attributedString.tighteningFactorForTruncation(5.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testTighteningFactorForTruncationWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tighteningFactorForTruncation = 1.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.tighteningFactorForTruncation(1.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpellingStateWithAttributedStringAndNoGrammarOrSpellingIssues() {
        // Given
        let attributes: Attributes = [
            .baselineOffset: NSNumber(value: 2.0)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newAttributes = attributes.merging([.spellingState: 0], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.spellingState(.noGrammarOrSpellingIssues)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpellingStateWithStringAndNoGrammarOrSpellingIssues() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.spellingState: 0])

        // When
        let result = string.spellingState(.noGrammarOrSpellingIssues)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpellingStateWithAttributedStringAndSpellingErrors() {
        // Given
        let attributes: Attributes = [
            .baselineOffset: NSNumber(value: 2.0),
            .spellingState: 0
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newAttributes = attributes.merging([.spellingState: 1], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.spellingState(.spellingErrors)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpellingStateWithStringAndSpellingErrors() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.spellingState: 1])

        // When
        let result = string.spellingState(.spellingErrors)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpellingStateWithAttributedStringAndGrammarErrors() {
        // Given
        let attributes: Attributes = [
            .kern: NSNumber(value: 1.0),
            .spellingState: 0
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newAttributes = attributes.merging([.spellingState: 2], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.spellingState(.grammarErrors)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpellingStateWithStringAndGrammarErrors() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.spellingState: 2])

        // When
        let result = string.spellingState(.grammarErrors)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSuperscriptWithAttributedStringAndDefaultValue() {
        // Given
        let attributes: Attributes = [
            .kern: NSNumber(value: 1.0),
            .superscript: NSNumber(value: 5)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newAttributes = attributes.merging([.superscript: NSNumber(value: 1)], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.superscript()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSuperscriptWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.superscript: NSNumber(value: 2)])

        // When
        let result = string.superscript(2)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testTextAlternativesWithAttributedString() throws {
        // Given
        let textAlternatives = NSTextAlternatives(primaryString: .unique(), alternativeStrings: [.unique()])
        let attributes: Attributes = [
            .font: NSFont.preferredFont(forTextStyle: .footnote),
            .textAlternatives: textAlternatives
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let primaryString = String.unique()
        let alternatives = [String.unique()]

        // When
        let result = attributedString.textAlternatives(primaryString: primaryString, alternativeStrings: alternatives)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        XCTAssertEqual(resultAttributes[.font] as? NSFont, NSFont.preferredFont(forTextStyle: .footnote))
        let resultTextAlternatives = try XCTUnwrap(resultAttributes[.textAlternatives] as? NSTextAlternatives)
        XCTAssertEqual(resultTextAlternatives.primaryString, primaryString)
        XCTAssertEqual(resultTextAlternatives.alternativeStrings, alternatives)
    }

    func testTextAlternativesWithString() throws {
        // Given
        let primaryString = String.unique()
        let alternatives = [String.unique()]

        // When
        let result = string.textAlternatives(primaryString: primaryString, alternativeStrings: alternatives)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultTextAlternatives = try XCTUnwrap(resultAttributes[.textAlternatives] as? NSTextAlternatives)
        XCTAssertEqual(resultTextAlternatives.primaryString, primaryString)
        XCTAssertEqual(resultTextAlternatives.alternativeStrings, alternatives)
    }

    func testToolTipWithAttributedString() {
        // Given
        let attributes: Attributes = [
            .foregroundColor: NSColor.red,
            .toolTip: String.unique()
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let toolTip = String.unique()
        let newAttributes = attributes.merging([.toolTip: toolTip as NSString], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.toolTip(toolTip)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testToolTipWithString() {
        // Given
        let toolTip = String.unique()
        let expected = NSAttributedString(string: string, attributes: [.toolTip: toolTip as NSString])

        // When
        let result = string.toolTip(toolTip)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testGlpyhInfoWithAttributedString() throws {
        // Given
        let baseString = "\u{FFFD}" // �
        let font = NSFont.systemFont(ofSize: 12)
        let glyphInfo = try XCTUnwrap(NSGlyphInfo(cgGlyph: 2590, for: font, baseString: baseString))

        let attributes: Attributes = [
            .foregroundColor: NSColor.gray,
            .font: font
        ]
        let attributedString = NSAttributedString(string: baseString, attributes: attributes)
        let newAttributes = attributes.merging([.glyphInfo: glyphInfo], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: baseString, attributes: newAttributes)

        // When
        let result = attributedString.glyphInfo(glyphInfo)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testGlpyhInfoWithString() throws {
        // Given
        let baseString = "\u{FFFD}" // �
        let font = NSFont.preferredFont(forTextStyle: .body)
        let glyphInfo = try XCTUnwrap(NSGlyphInfo(cgGlyph: 2590, for: font, baseString: baseString))
        let attributes: Attributes = [
            .glyphInfo: glyphInfo,
            .font: font
        ]
        let expected = NSAttributedString(string: baseString, attributes: attributes)

        // When
        let result = baseString.glyphInfo(glyphInfo)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testMarkedClauseSegmentWithAttributedString() {
        // Given
        let attributes: Attributes = [
            .baselineOffset: NSNumber(value: 1),
            .font: AFont.preferredFont(forTextStyle: .callout)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newAttributes = attributes.merging([.markedClauseSegment: NSNumber(value: 2)], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString
            .markedClauseSegment(2)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testMarkedClauseSegmentWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.markedClauseSegment: NSNumber(value: 1)])

        // When
        let result = string
            .markedClauseSegment(1)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testHeaderLevelWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headerLevel = 2
        paragraphStyle.alignment = .center
        let attributes: Attributes = [
            .foregroundColor: NSColor.red,
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.headerLevel = 1
        newParagraphStyle.alignment = .center
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.headerLevel(1)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testHeaderLevelWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headerLevel = 3
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.headerLevel(3)

        // Then
        XCTAssertEqual(result, expected)
    }

    // MARK: - Accessibility

    func testAccessibilityAlignmentWithAttributedString() {
        // Given
        let alignment: NSTextAlignment = .center
        let attributes: Attributes = [
            .foregroundColor: AColor.orange
        ]
        let newAttributes: Attributes = [
            .foregroundColor: AColor.orange,
            .accessibilityAlignment: NSNumber(value: alignment.rawValue)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilityAlignment(alignment)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityAlignmentWithString() {
        // Given
        let alignment: NSTextAlignment = .center
        let attributes: Attributes = [
            .accessibilityAlignment: NSNumber(value: alignment.rawValue)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityAlignment(alignment)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityAutocorrectedWithAttributedString() {
        // Given
        let isAutocorrected = Bool.random()
        let attributes: Attributes = [
            .foregroundColor: AColor.orange
        ]
        let newAttributes: Attributes = [
            .foregroundColor: AColor.orange,
            .accessibilityAutocorrected: NSNumber(value: isAutocorrected)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilityAutocorrected(isAutocorrected)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityAutocorrectedWithString() {
        // Given
        let isAutocorrected = Bool.random()
        let attributes: Attributes = [
            .accessibilityAutocorrected: NSNumber(value: isAutocorrected)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityAutocorrected(isAutocorrected)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityForegroundColorWithAttributedString() {
        // Given
        let color = AColor.cyan
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityForegroundColor: color.cgColor
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilityForegroundColor(color)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityForegroundColorWithString() {
        // Given
        let color = AColor.cyan
        let attributes: Attributes = [
            .accessibilityForegroundColor: color.cgColor
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityForegroundColor(color)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityBackgroundColorWithAttributedString() {
        // Given
        let color = AColor.cyan
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityBackgroundColor: color.cgColor
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilityBackgroundColor(color)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityBackgroundColorWithString() {
        // Given
        let color = AColor.orange
        let attributes: Attributes = [
            .accessibilityBackgroundColor: color.cgColor
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityBackgroundColor(color)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityLanguageWithAttributedString() {
        // Given
        let language: NSAttributedStringBuilder.LanguageCode = .greek
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityLanguage: language.rawValue as NSString
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilityLanguage(language)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityLanguageWithString() {
        // Given
        let language: NSAttributedStringBuilder.LanguageCode = .french
        let attributes: Attributes = [
            .accessibilityLanguage: language.rawValue as NSString
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityLanguage(language)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityMarkedMisspelledWithAttributedString() {
        // Given
        let isMisspelled = Bool.random()
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityMarkedMisspelled: NSNumber(value: isMisspelled)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilityMarkedMisspelled(isMisspelled)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityMarkedMisspelledWithString() {
        // Given
        let isMisspelled = Bool.random()
        let attributes: Attributes = [
            .accessibilityMarkedMisspelled: NSNumber(value: isMisspelled)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityMarkedMisspelled(isMisspelled)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityShadowWithAttributedString() {
        // Given
        let hasShadow = Bool.random()
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let newAttributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .accessibilityShadow: NSNumber(value: hasShadow)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.accessibilityShadow(hasShadow)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAccessibilityShadowWithString() {
        // Given
        let hasShadow = Bool.random()
        let attributes: Attributes = [
            .accessibilityShadow: NSNumber(value: hasShadow)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityShadow(hasShadow)

        // Then
        XCTAssertEqual(result, expected)
    }
}
#endif
