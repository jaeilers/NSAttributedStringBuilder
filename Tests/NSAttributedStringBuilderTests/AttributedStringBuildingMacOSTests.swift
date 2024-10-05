#if canImport(AppKit)
import AppKit
import NSAttributedStringBuilder
import Testing

@Suite
struct AttributedStringBuildingMacOSTests {

    private let string = String.unique()

    @Test
    func imageWithAttributedString() throws {
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
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image != nil)
        #expect(resultAttachment.image?.accessibilityDescription == accessibilityDescription)
        #expect(resultAttachment.bounds == bounds)
        #expect(resultAttributes[.font] as? NSFont == NSFont.preferredFont(forTextStyle: .headline))
        #expect(resultAttributes[.foregroundColor] as? NSColor == NSColor.textColor)
        #expect(resultAttributes[.kern] as? NSNumber == NSNumber(value: 1.0))

        let resultAttributedString = result.attributedSubstring(from: NSRange(location: 0, length: attributedString.length))
        #expect(resultAttributedString == attributedString)
    }

    @Test
    func imageWithAttributedStringAndSystemName() throws {
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
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image != nil)
        #expect(resultAttachment.image?.accessibilityDescription == accessibilityDescription)
        #expect(resultAttachment.bounds == bounds)
        #expect(resultAttributes[.font] as? NSFont == NSFont.preferredFont(forTextStyle: .headline))
        #expect(resultAttributes[.foregroundColor] as? NSColor == NSColor.textColor)
        #expect(resultAttributes[.kern] as? NSNumber == NSNumber(value: 1.0))

        let resultAttributedString = result.attributedSubstring(from: NSRange(location: 0, length: attributedString.length))
        #expect(resultAttributedString == attributedString)
    }

    @Test
    func imageWithAttributedStringAndSystemNameIsUnknown() {
        // Given
        let attributedString = NSAttributedString(string: string)

        // When
        let result = attributedString.image(systemName: .unique())

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        #expect(resultAttributes[.attachment] as? NSTextAttachment == nil)
    }

    @Test
    func cursorWithAttributedString() throws {
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
        #expect(result == expected)
    }

    @Test
    func cursorWithString() throws {
        // Given
        let cursor = NSCursor.arrow
        let expected = NSAttributedString(string: string, attributes: [.cursor: cursor])

        // When
        let result = string.cursor(cursor)

        // Then
        #expect(result == expected)
    }

    @Test
    func tighteningFactorForTruncationWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func tighteningFactorForTruncationWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tighteningFactorForTruncation = 1.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.tighteningFactorForTruncation(1.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func spellingStateWithAttributedStringAndNoGrammarOrSpellingIssues() {
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
        #expect(result == expected)
    }

    @Test
    func spellingStateWithStringAndNoGrammarOrSpellingIssues() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.spellingState: 0])

        // When
        let result = string.spellingState(.noGrammarOrSpellingIssues)

        // Then
        #expect(result == expected)
    }

    @Test
    func spellingStateWithAttributedStringAndSpellingErrors() {
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
        #expect(result == expected)
    }

    @Test
    func spellingStateWithStringAndSpellingErrors() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.spellingState: 1])

        // When
        let result = string.spellingState(.spellingErrors)

        // Then
        #expect(result == expected)
    }

    @Test
    func spellingStateWithAttributedStringAndGrammarErrors() {
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
        #expect(result == expected)
    }

    @Test
    func spellingStateWithStringAndGrammarErrors() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.spellingState: 2])

        // When
        let result = string.spellingState(.grammarErrors)

        // Then
        #expect(result == expected)
    }

    @Test
    func superscriptWithAttributedStringAndDefaultValue() {
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
        #expect(result == expected)
    }

    @Test
    func superscriptWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.superscript: NSNumber(value: 2)])

        // When
        let result = string.superscript(2)

        // Then
        #expect(result == expected)
    }

    @Test
    func textAlternativesWithAttributedString() throws {
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
        #expect(resultAttributes[.font] as? NSFont == NSFont.preferredFont(forTextStyle: .footnote))
        let resultTextAlternatives = try #require(resultAttributes[.textAlternatives] as? NSTextAlternatives)
        #expect(resultTextAlternatives.primaryString == primaryString)
        #expect(resultTextAlternatives.alternativeStrings == alternatives)
    }

    @Test
    func textAlternativesWithString() throws {
        // Given
        let primaryString = String.unique()
        let alternatives = [String.unique()]

        // When
        let result = string.textAlternatives(primaryString: primaryString, alternativeStrings: alternatives)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultTextAlternatives = try #require(resultAttributes[.textAlternatives] as? NSTextAlternatives)
        #expect(resultTextAlternatives.primaryString == primaryString)
        #expect(resultTextAlternatives.alternativeStrings == alternatives)
    }

    @Test
    func toolTipWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func toolTipWithString() {
        // Given
        let toolTip = String.unique()
        let expected = NSAttributedString(string: string, attributes: [.toolTip: toolTip as NSString])

        // When
        let result = string.toolTip(toolTip)

        // Then
        #expect(result == expected)
    }

    @Test
    func glyphInfoWithAttributedString() throws {
        // Given
        let baseString = "\u{FFFD}" // �
        let font = NSFont.systemFont(ofSize: 12)
        let glyphInfo = try #require(NSGlyphInfo(cgGlyph: 2590, for: font, baseString: baseString))

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
        #expect(result == expected)
    }

    @Test
    func glyphInfoWithString() throws {
        // Given
        let baseString = "\u{FFFD}" // �
        let font = NSFont.preferredFont(forTextStyle: .body)
        let glyphInfo = try #require(NSGlyphInfo(cgGlyph: 2590, for: font, baseString: baseString))
        let attributes: Attributes = [
            .glyphInfo: glyphInfo,
            .font: font
        ]
        let expected = NSAttributedString(string: baseString, attributes: attributes)

        // When
        let result = baseString.glyphInfo(glyphInfo)

        // Then
        #expect(result == expected)
    }

    @Test
    func markedClauseSegmentWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func markedClauseSegmentWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.markedClauseSegment: NSNumber(value: 1)])

        // When
        let result = string
            .markedClauseSegment(1)

        // Then
        #expect(result == expected)
    }

    @Test
    func headerLevelWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func headerLevelWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headerLevel = 3
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.headerLevel(3)

        // Then
        #expect(result == expected)
    }

    // MARK: - Accessibility

    @Test
    func accessibilityAlignmentWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func accessibilityAlignmentWithString() {
        // Given
        let alignment: NSTextAlignment = .center
        let attributes: Attributes = [
            .accessibilityAlignment: NSNumber(value: alignment.rawValue)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityAlignment(alignment)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilityAutocorrectedWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func accessibilityAutocorrectedWithString() {
        // Given
        let isAutocorrected = Bool.random()
        let attributes: Attributes = [
            .accessibilityAutocorrected: NSNumber(value: isAutocorrected)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityAutocorrected(isAutocorrected)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilityForegroundColorWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func accessibilityForegroundColorWithString() {
        // Given
        let color = AColor.cyan
        let attributes: Attributes = [
            .accessibilityForegroundColor: color.cgColor
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityForegroundColor(color)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilityBackgroundColorWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func accessibilityBackgroundColorWithString() {
        // Given
        let color = AColor.orange
        let attributes: Attributes = [
            .accessibilityBackgroundColor: color.cgColor
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityBackgroundColor(color)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilityLanguageWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func accessibilityLanguageWithString() {
        // Given
        let language: NSAttributedStringBuilder.LanguageCode = .french
        let attributes: Attributes = [
            .accessibilityLanguage: language.rawValue as NSString
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityLanguage(language)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilityMarkedMisspelledWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func accessibilityMarkedMisspelledWithString() {
        // Given
        let isMisspelled = Bool.random()
        let attributes: Attributes = [
            .accessibilityMarkedMisspelled: NSNumber(value: isMisspelled)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityMarkedMisspelled(isMisspelled)

        // Then
        #expect(result == expected)
    }

    @Test
    func accessibilityShadowWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func accessibilityShadowWithString() {
        // Given
        let hasShadow = Bool.random()
        let attributes: Attributes = [
            .accessibilityShadow: NSNumber(value: hasShadow)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.accessibilityShadow(hasShadow)

        // Then
        #expect(result == expected)
    }
}
#endif
