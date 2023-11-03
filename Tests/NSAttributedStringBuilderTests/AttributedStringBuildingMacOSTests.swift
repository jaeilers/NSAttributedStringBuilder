#if canImport(AppKit)
import NSAttributedStringBuilder
import XCTest

final class AttributedStringBuildingMacOSTests: XCTestCase {

    private let string = String.unique()

    func testNSImageWithAttributedString() throws {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
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
        let attributes: [NSAttributedString.Key: Any] = [
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
        let attributes: [NSAttributedString.Key: Any] = [
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
        paragraphStyle.tighteningFactorForTruncation = 1.0
        let attributedString = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])
        let newParagraphStyle = NSMutableParagraphStyle()
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
        let attributes: [NSAttributedString.Key: Any] = [
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
        let attributes: [NSAttributedString.Key: Any] = [
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
        let attributes: [NSAttributedString.Key: Any] = [
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
        let attributes: [NSAttributedString.Key: Any] = [
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
        let attributes: [NSAttributedString.Key: Any] = [
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
        let attributes: [NSAttributedString.Key: Any] = [
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

    func testHeaderLevelWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headerLevel = 2
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: NSColor.red,
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.headerLevel = 1
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
}
#endif
