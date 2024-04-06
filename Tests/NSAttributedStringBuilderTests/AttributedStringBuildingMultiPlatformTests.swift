import NSAttributedStringBuilder
import XCTest

final class AttributedStringBuildingMultiPlatformTests: XCTestCase {

    private let string = String.unique()

    // MARK: - Platform independent

    func testTextWithAttributedString() {
        // Given
        let newString = String.unique()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AColor.yellow
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + newString, attributes: attributes)

        // When
        let result = attributedString.text(newString)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testTextWithString() {
        // Given
        let newString = String.unique()
        let expected = NSAttributedString(string: string + newString)

        // When
        let result = string.text(newString)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testKerningWithAttributedString() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .headline)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expectedAttributes = attributes.merging([.kern: NSNumber(value: 1.0)], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: expectedAttributes)

        // When
        let result = attributedString.kerning(1.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testKerningWithString() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .kern: NSNumber(value: 1.0)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.kerning(1.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpaceWithAttributedStringAndStandardSpace() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .baselineOffset: NSNumber(value: 1)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + " ", attributes: attributes)

        // When
        let result = attributedString.space()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpaceWithStringAndStandardSpace() {
        // Given
        let expected = NSAttributedString(string: string + " ")

        // When
        let result = string.space()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpaceWithAttributedStringAndENSpace() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + "\u{2002}", attributes: attributes)

        // When
        let result = attributedString.space(.enSpace)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpaceWithStringAndENSpace() {
        // Given
        let expected = NSAttributedString(string: string + "\u{2002}")

        // When
        let result = string.space(.enSpace)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpaceWithAttributedStringAndEMSpace() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .backgroundColor: AColor.brown
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + "\u{2003}", attributes: attributes)

        // When
        let result = attributedString.space(.emSpace)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testSpaceWithStringAndEMSpace() {
        // Given
        let expected = NSAttributedString(string: string + "\u{2003}")

        // When
        let result = string.space(.emSpace)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testNonBreakingSpaceWithAttributedString() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .foregroundColor: AColor.blue
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + "\u{00A0}", attributes: attributes)

        // When
        let result = attributedString.nonBreakingSpace()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testNonBreakingSpaceWithString() {
        // Given
        let expected = NSAttributedString(string: string + "\u{00A0}")

        // When
        let result = string.nonBreakingSpace()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testNarrowNonBreakingSpaceWithAttributedString() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .foregroundColor: AColor.blue
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + "\u{202F}", attributes: attributes)

        // When
        let result = attributedString.space(.narrowNonBreakingSpace)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testNarrowNonBreakingSpaceWithString() {
        // Given
        let expected = NSAttributedString(string: string + "\u{202F}")

        // When
        let result = string.space(.narrowNonBreakingSpace)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testNewlineWithAttributedString() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .backgroundColor: AColor.black
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + "\n", attributes: attributes)

        // When
        let result = attributedString.newline()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testNewlineWithString() {
        // Given
        let expected = NSAttributedString(string: string + "\n")

        // When
        let result = string.newline()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLinkWithAttributedString() throws {
        // Given
        let url = try XCTUnwrap(URL(string: "https://apple.com"))
        let attributes: [NSAttributedString.Key: Any] = [
            .backgroundColor: AColor.yellow
        ]
        let expectedAttributes = attributes.merging([.link: url as NSURL], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: expectedAttributes)

        // When
        let result = attributedString.link(url)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLinkWithString() throws {
        // Given
        let url = try XCTUnwrap(URL(string: "https://apple.com"))
        let attributes: [NSAttributedString.Key: Any] = [
            .link: url as NSURL
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.link(url)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testBaselineOffsetWithAttributedString() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AColor.lightGray
        ]
        let newAttributes = attributes.merging([.baselineOffset: NSNumber(value: 2.0)], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.baselineOffset(2.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testBaselineOffsetWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.baselineOffset: NSNumber(value: 2.0)])

        // When
        let result = string.baselineOffset(2.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLigatureWithAttributedStringAndNoLigature() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .caption1)
        ]
        let newAttributes = attributes.merging([.ligature: NSNumber(value: 0)], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.ligature(.none)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLigatureWithStringAndNoLigature() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.ligature: NSNumber(value: 0)])

        // When
        let result = string.ligature(.none)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLigatureWithAttributedStringAndDefaultLigatures() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .kern: NSNumber(value: 5.0)
        ]
        let newAttributes = attributes.merging([.ligature: NSNumber(value: 1)], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.ligature(.default)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLigatureWithStringAndDefaultLigatures() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.ligature: NSNumber(value: 1)])

        // When
        let result = string.ligature(.default)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testTextEffectWithAttributedStringAndLetterpressStyle() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
        ]
        let newAttributes = attributes.merging(
            [.textEffect: NSAttributedString.TextEffectStyle.letterpressStyle as NSString],
            uniquingKeysWith: { _, new in new }
        )
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.textEffect(.letterpressStyle)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testTextEffectWithStringAndLetterpressStyle() {
        // Given
        let expected = NSAttributedString(
            string: string,
            attributes: [.textEffect: NSAttributedString.TextEffectStyle.letterpressStyle as NSString]
        )

        // When
        let result = string.textEffect(.letterpressStyle)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testWritingDirectionWithAttributedStringAndLeftToRightEmbedding() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote)
        ]
        let newAttributes = attributes.merging(
            [.writingDirection: [NSWritingDirection.leftToRight.rawValue | NSWritingDirectionFormatType.embedding.rawValue]],
            uniquingKeysWith: { _, new in new }
        )
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.writingDirection(.leftToRightDirectionEmbedding)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testWritingDirectionWithStringAndLeftToRightEmbedding() {
        // Given
        let expected = NSAttributedString(
            string: string,
            attributes: [.writingDirection: [NSWritingDirection.leftToRight.rawValue | NSWritingDirectionFormatType.embedding.rawValue]]
        )

        // When
        let result = string.writingDirection(.leftToRightDirectionEmbedding)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testWritingDirectionWithAttributedStringAndLeftToRightOverride() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .backgroundColor: AColor.black
        ]
        let newAttributes = attributes.merging(
            [.writingDirection: [NSWritingDirection.leftToRight.rawValue | NSWritingDirectionFormatType.override.rawValue]],
            uniquingKeysWith: { _, new in new }
        )
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.writingDirection(.leftToRightDirectionOverride)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testWritingDirectionWithStringAndLeftToRightOverride() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.writingDirection: [NSWritingDirection.leftToRight.rawValue | NSWritingDirectionFormatType.override.rawValue]])

        // When
        let result = string.writingDirection(.leftToRightDirectionOverride)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testWritingDirectionWithAttributedStringAndRightToLeftEmbedding() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AColor.blue
        ]
        let newAttributes = attributes.merging([.writingDirection: [NSWritingDirection.rightToLeft.rawValue | NSWritingDirectionFormatType.embedding.rawValue]], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.writingDirection(.rightToLeftDirectionEmbedding)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testWritingDirectionWithStringAndRightToLeftEmbedding() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.writingDirection: [NSWritingDirection.rightToLeft.rawValue | NSWritingDirectionFormatType.embedding.rawValue]])

        // When
        let result = string.writingDirection(.rightToLeftDirectionEmbedding)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testWritingDirectionWithAttributedStringAndRightToLeftOverride() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .headline)
        ]
        let newAttributes = attributes.merging([.writingDirection: [NSWritingDirection.rightToLeft.rawValue | NSWritingDirectionFormatType.override.rawValue]], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.writingDirection(.rightToLeftDirectionOverride)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testWritingDirectionWithStringAndRightToLeftOverride() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.writingDirection: [NSWritingDirection.rightToLeft.rawValue | NSWritingDirectionFormatType.override.rawValue]])

        // When
        let result = string.writingDirection(.rightToLeftDirectionOverride)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLanguageWithAttributedString() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .footnote)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newAttributes = attributes.merging([NSAttributedString.Key(String(kCTLanguageAttributeName)): "en"], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.language(.english)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLanguageIdentifierWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [NSAttributedString.Key(String(kCTLanguageAttributeName)): "de"])

        // When
        let result = string.language(.german)

        // Then
        XCTAssertEqual(result, expected)
    }

    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    func testLanguageIdentifierWithLanguageCodeAndAttributedString() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .footnote)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newAttributes = attributes.merging([.languageIdentifier: "it"], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.languageIdentifier(.italian)

        // Then
        XCTAssertEqual(result, expected)
    }

    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    func testLanguageIdentifierWithLanguageIdentifierAndString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.languageIdentifier: "fr"])

        // When
        let result = string.languageIdentifier(.french)

        // Then
        XCTAssertEqual(result, expected)
    }

    @available(iOS 14, tvOS 14, watchOS 7, *)
    func testTrackingWithAttributedString() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .foregroundColor: AColor.yellow
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newAttributes = attributes.merging([.tracking: NSNumber(value: 2)], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.tracking(2)

        // Then
        XCTAssertEqual(result, expected)
    }

    @available(iOS 14, tvOS 14, watchOS 7, *)
    func testTrackingWithString() {
        // Given
        let attributes: Attributes = [
            .tracking: NSNumber(value: 5)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.tracking(5)

        // Then
        XCTAssertEqual(result, expected)
    }

    // MARK: - Paragraph Styles

    func testParagraphStyleWithAttributedString() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.lineSpacing = 10.0
        paragraphStyle.lineHeightMultiple = 2.0
        paragraphStyle.headIndent = 2.0
        let newAttributes = attributes.merging([.paragraphStyle: paragraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.paragraphStyle(paragraphStyle)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testParagraphStyleWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.allowsDefaultTighteningForTruncation = true
        paragraphStyle.maximumLineHeight = 123.0
        paragraphStyle.minimumLineHeight = 1.0
        paragraphStyle.tailIndent = 1.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.paragraphStyle(paragraphStyle)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testParagraphStyleWithAttributedStringOverrideExistingParagraphStyle() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.headIndent = 1.0
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributedString = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        let newParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        paragraphStyle.baseWritingDirection = .leftToRight
        paragraphStyle.hyphenationFactor = 1.0
        paragraphStyle.lineBreakMode = .byTruncatingTail
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: newParagraphStyle])

        // When
        let result = attributedString.paragraphStyle(newParagraphStyle)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAlignmentWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 2.0
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.alignment = .natural
        newParagraphStyle.lineSpacing = 2.0
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.alignment(.natural)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAlignmentWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.alignment(.center)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testFirstLineHeadIndentWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .headline),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.firstLineHeadIndent = 123.0
        newParagraphStyle.alignment = .center
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.firstLineHeadIndent(123.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testFirstLineHeadIndentWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 42.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.firstLineHeadIndent(42.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testHeadIndentWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.headIndent = 42.0
        newParagraphStyle.lineBreakMode = .byWordWrapping
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.headIndent(42.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testHeadIndentWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 1.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.headIndent(1.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testTailIndentWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.tailIndent = 13.0
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.tailIndent(13.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testTailIndentWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tailIndent = 2.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.tailIndent(2.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLineHeightMultipleWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.lineHeightMultiple = 1.0
        newParagraphStyle.alignment = .center
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.lineHeightMultiple(1.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLineHeightMultipleWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 4.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.lineHeightMultiple(4.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testMaximumLineHeightWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20.0
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.maximumLineHeight = 5.0
        newParagraphStyle.lineSpacing = 20.0
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.maximumLineHeight(5.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testMaximumLineHeightWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = 10.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.maximumLineHeight(10.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testMinimumLineHeightWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8.0
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.minimumLineHeight = 1.0
        newParagraphStyle.lineSpacing = 8.0
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.minimumLineHeight(1.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testMinimumLineHeightWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 3.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.minimumLineHeight(3.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLineSpacingWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.lineSpacing = 5.0
        newParagraphStyle.alignment = .right
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.lineSpacing(5.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLineSpacingWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.lineSpacing(1.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testParagraphSpacingWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.paragraphSpacing = 16.0
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.paragraphSpacing(16.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testParagraphSpacingWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 4.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.paragraphSpacing(4.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testParagraphSpacingBeforeWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.paragraphSpacingBefore = 3.0
        newParagraphStyle.alignment = .natural
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.paragraphSpacingBefore(3.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testParagraphSpacingBeforeWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacingBefore = 1.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.paragraphSpacingBefore(1.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLineBreakModeWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.0
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.lineBreakMode = .byTruncatingTail
        newParagraphStyle.lineSpacing = 2.0
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.lineBreakMode(.byTruncatingTail)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLineBreakModeWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.lineBreakMode(.byWordWrapping)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLineBreakStrategyWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 2.0
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.lineBreakStrategy = .pushOut
        newParagraphStyle.hyphenationFactor = 2.0
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.lineBreakStrategy(.pushOut)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLineBreakStrategyWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakStrategy = .pushOut
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.lineBreakStrategy(.pushOut)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testHyphenationFactorWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.hyphenationFactor = 0.5
        newParagraphStyle.alignment = .center
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.hyphenationFactor(0.5)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testHyphenationFactorWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 1.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.hyphenationFactor(1.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    @available(iOS 15, macOS 13, watchOS 8, tvOS 15, *)
    func testUsesDefaultHyphenationWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.usesDefaultHyphenation = true
        newParagraphStyle.alignment = .center
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.usesDefaultHyphenation(true)

        // Then
        XCTAssertEqual(result, expected)
    }

    @available(iOS 15, macOS 13, watchOS 8, tvOS 15, *)
    func testUsesDefaultHyphenationWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.usesDefaultHyphenation = false
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.usesDefaultHyphenation(false)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAllowsDefaultTighteningForTruncationWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.allowsDefaultTighteningForTruncation = true
        newParagraphStyle.alignment = .center
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.allowsDefaultTighteningForTruncation(true)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAllowsDefaultTighteningForTruncationWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.allowsDefaultTighteningForTruncation = false
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.allowsDefaultTighteningForTruncation(false)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testBaseWritingDirectionWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.baseWritingDirection = .leftToRight
        newParagraphStyle.alignment = .center
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.baseWritingDirection(.leftToRight)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testBaseWritingDirectionWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.baseWritingDirection = .rightToLeft
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.baseWritingDirection(.rightToLeft)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testTabStopsWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 0)]
        newParagraphStyle.defaultTabInterval = 3.0
        newParagraphStyle.alignment = .center
        let newAttributes = attributes.merging([.paragraphStyle: newParagraphStyle], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.tabStops([NSTextTab(textAlignment: .left, location: 0)], defaultInterval: 3.0)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testTabStopsWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .center, location: 0)]
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.tabStops([NSTextTab(textAlignment: .center, location: 0)])

        // Then
        XCTAssertEqual(result, expected)
    }

    func testMultipleParagraphStylesWithAttributedStringAndExistingParagraphStyle() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 13.0
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.hyphenationFactor = 1.0
        newParagraphStyle.lineSpacing = 2.0
        newParagraphStyle.paragraphSpacing = 3.0
        newParagraphStyle.lineBreakMode = .byWordWrapping
        newParagraphStyle.alignment = .center
        let newAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: newParagraphStyle
        ]
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString
            .hyphenationFactor(1.0)
            .lineSpacing(2.0)
            .paragraphSpacing(3.0)
            .lineBreakMode(.byWordWrapping)
            .alignment(.center)

        // Then
        XCTAssertEqual(result, expected)
    }

    // MARK: - Platform dependent (typealias)

    func testFontWithAttributedStringOverridesExistingFont() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AFont.preferredFont(forTextStyle: .footnote)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: [.font: AFont.preferredFont(forTextStyle: .headline)])

        // When
        let result = attributedString.font(AFont.preferredFont(forTextStyle: .headline))

        // Then
        XCTAssertEqual(result, expected)
    }

    func testFontWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.font: AFont.preferredFont(forTextStyle: .caption1)])

        // When
        let result = string.font(AFont.preferredFont(forTextStyle: .caption1))

        // Then
        XCTAssertEqual(result, expected)
    }

    func testForegroundColorWithAttributedStringOverridesExistingColor() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AColor.black
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: [.foregroundColor: AColor.yellow])

        // When
        let result = attributedString.foregroundColor(AColor.yellow)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testForegroundColorWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.foregroundColor: AColor.cyan])

        // When
        let result = string.foregroundColor(AColor.cyan)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testBackgroundColorWithAttributedStringOverridesExistingColor() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .backgroundColor: AColor.yellow
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: [.backgroundColor: AColor.blue])

        // When
        let result = attributedString.backgroundColor(AColor.blue)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testBackgroundColorWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.backgroundColor: AColor.cyan])

        // When
        let result = string.backgroundColor(AColor.cyan)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testUnderlineStyleWithAttributedStringOverridesExistingValue() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: [.underlineStyle: NSNumber(value: NSUnderlineStyle.double.rawValue)])

        // When
        let result = attributedString.underline(.double)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testUnderlineStyleWithAttributedStringAndUnderlineColorOverridesExistingValues() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .underlineColor: AColor.black
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(
            string: string,
            attributes: [
                .underlineStyle: NSNumber(value: NSUnderlineStyle.double.rawValue),
                .underlineColor: AColor.brown
            ]
        )

        // When
        let result = attributedString.underline(.double, color: AColor.brown)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testUnderlineStyleWithAttributedStringAndUnderlineColorNoColorDoesNotResetExistingValue() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .underlineColor: AColor.yellow
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(
            string: string,
            attributes: [
                .underlineStyle: NSNumber(value: NSUnderlineStyle.double.rawValue),
                .underlineColor: AColor.yellow
            ]
        )

        // When
        let result = attributedString.underline(.double)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testUnderlineStyleWithString() {
        // Given
        let expected = NSAttributedString(
            string: string,
            attributes: [
                .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
            ]
        )

        // When
        let result = string.underline(.single)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testUnderlineStyleWithStringAndUnderlineColor() {
        // Given
        let expected = NSAttributedString(
            string: string,
            attributes: [
                .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
                .underlineColor: AColor.cyan
            ]
        )

        // When
        let result = string.underline(.single, color: AColor.cyan)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testStrikethroughWithAttributedStringOverridesExistingValue() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.double.rawValue)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(
            string: string,
            attributes: [
                .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
            ]
        )

        // When
        let result = attributedString.strikethrough()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testStrikethroughWithAttributedStringAndColorOverridesExistingValues() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .strikethroughColor: AColor.black
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(
            string: string,
            attributes: [
                .strikethroughStyle: NSNumber(value: NSUnderlineStyle.double.rawValue),
                .strikethroughColor: AColor.orange
            ]
        )

        // When
        let result = attributedString.strikethrough(.double, color: AColor.orange)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testStrikethroughWithAttributedStringAndNoColorDoesNotOverrideExistingValue() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .strikethroughColor: AColor.orange
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(
            string: string,
            attributes: [
                .strikethroughStyle: NSNumber(value: NSUnderlineStyle.double.rawValue),
                .strikethroughColor: AColor.orange
            ]
        )

        // When
        let result = attributedString.strikethrough(.double)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testStrikethroughWithString() {
        // Given
        let expected = NSAttributedString(
            string: string,
            attributes: [
                .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
            ]
        )

        // When
        let result = string.strikethrough()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testStrikethroughWithStringAndUnderlineColor() {
        // Given
        let expected = NSAttributedString(
            string: string,
            attributes: [
                .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
                .strikethroughColor: AColor.cyan
            ]
        )

        // When
        let result = string.strikethrough(.single, color: AColor.cyan)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testShadowWithAttributedStringDefaultValuesAreAppliedAndOverrideExistingValues() {
        // Given
        let shadow = NSShadow()
        shadow.shadowOffset = .init(width: 5, height: 5)
        shadow.shadowBlurRadius = 10.0
        let attributedString = NSAttributedString(string: string, attributes: [.shadow: shadow])
        let newShadow = NSShadow()
        newShadow.shadowOffset = .init(width: 1, height: 1)
        newShadow.shadowBlurRadius = 5.0
        let expected = NSAttributedString(string: string, attributes: [.shadow: newShadow])

        // When
        let result = attributedString.shadow()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testShadowWithAttributedStringAndColor() {
        // Given
        let shadow = NSShadow()
        shadow.shadowOffset = .init(width: 5, height: 5)
        shadow.shadowBlurRadius = 10.0
        shadow.shadowColor = AColor.red
        let attributedString = NSAttributedString(string: string, attributes: [.shadow: shadow])
        let newShadow = NSShadow()
        newShadow.shadowOffset = .init(width: 10, height: 10)
        newShadow.shadowBlurRadius = 1.0
        newShadow.shadowColor = AColor.yellow
        let expected = NSAttributedString(string: string, attributes: [.shadow: newShadow])

        // When
        let result = attributedString.shadow(
            offset: .init(width: 10, height: 10),
            blurRadius: 1,
            color: AColor.yellow
        )

        // Then
        XCTAssertEqual(result, expected)
    }

    func testShadowWithAttributedStringNoColorDoNotOverrideExistingColor() {
        // Given
        let shadow = NSShadow()
        shadow.shadowOffset = .init(width: 5, height: 5)
        shadow.shadowBlurRadius = 10.0
        shadow.shadowColor = AColor.red
        let attributedString = NSAttributedString(string: string, attributes: [.shadow: shadow])
        let newShadow = NSShadow()
        newShadow.shadowOffset = .init(width: 10, height: 10)
        newShadow.shadowBlurRadius = 1.0
        newShadow.shadowColor = AColor.red
        let expected = NSAttributedString(string: string, attributes: [.shadow: newShadow])

        // When
        let result = attributedString.shadow(
            offset: .init(width: 10, height: 10),
            blurRadius: 1,
            color: nil
        )

        // Then
        XCTAssertEqual(result, expected)
    }

    func testShadowWithString() {
        // Given
        let shadow = NSShadow()
        shadow.shadowOffset = .init(width: 1, height: 1)
        shadow.shadowBlurRadius = 5.0
        let expected = NSAttributedString(string: string, attributes: [.shadow: shadow])

        // When
        let result = string.shadow()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testShadowWithStringAndColor() {
        // Given
        let shadow = NSShadow()
        shadow.shadowOffset = .init(width: 15, height: 15)
        shadow.shadowBlurRadius = 10.0
        shadow.shadowColor = AColor.red
        let expected = NSAttributedString(string: string, attributes: [.shadow: shadow])

        // When
        let result = string.shadow(
            offset: .init(width: 15, height: 15),
            blurRadius: 10,
            color: AColor.red
        )

        // Then
        XCTAssertEqual(result, expected)
    }

    func testStrokeWithAttributedStringOverridesExistingValueAndDefaultValueIsApplied() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: NSNumber(value: 10)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: [.strokeWidth: NSNumber(value: 2.0)])

        // When
        let result = attributedString.stroke()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testStrokeWithAttributedStringAndColorOverridesExistingValues() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: NSNumber(value: 10),
            .strokeColor: AColor.orange
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(
            string: string, attributes: [
                .strokeWidth: NSNumber(value: 3.0),
                .strokeColor: AColor.red
            ]
        )

        // When
        let result = attributedString.stroke(
            width: 3.0,
            color: AColor.red
        )

        // Then
        XCTAssertEqual(result, expected)
    }

    func testStrokeWithAttributedStringNoColorDoesNotOverrideExistingColor() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: NSNumber(value: 10),
            .strokeColor: AColor.orange
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(
            string: string, attributes: [
                .strokeWidth: NSNumber(value: 3.0),
                .strokeColor: AColor.red
            ]
        )

        // When
        let result = attributedString.stroke(
            width: 3.0,
            color: AColor.red
        )

        // Then
        XCTAssertEqual(result, expected)
    }

    // MARK: - All platforms but iOS

    #if !os(iOS)
    func testLigatureWithAttributedStringAndAllLigatures() {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .baselineOffset: NSNumber(value: 13)
        ]
        let newAttributes = attributes.merging([.ligature: NSNumber(value: 2)], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.ligature(.all)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLigatureWithStringAndAllLigatures() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.ligature: NSNumber(value: 2)])

        // When
        let result = string.ligature(.all)

        // Then
        XCTAssertEqual(result, expected)
    }
    #endif

    // MARK: - All platforms but watchOS

    #if !os(watchOS)
    func testSpaceWithAttributedStringAndCustomSpace() throws {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AColor.red
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let attachment = NSTextAttachment()
        attachment.bounds = .init(origin: .zero, size: .init(width: 1.0, height: 0.001))
        let newAttributedString = NSMutableAttributedString(attachment: attachment)
        newAttributedString.addAttributes(attributes, range: NSRange(location: 0, length: newAttributedString.length))

        let expected = NSMutableAttributedString()
        expected.append(attributedString)
        expected.append(newAttributedString)

        // When
        let result = attributedString.space(.custom(1.0))

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        XCTAssertEqual(resultAttributes[.foregroundColor] as? AColor, AColor.red)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.bounds.size.width, 1.0)
        XCTAssertEqual(resultAttachment.bounds.size.height, 0.001)
    }

    func testSpaceWithStringAndCustomSpace() throws {
        // Given
        let attachment = NSTextAttachment()
        attachment.bounds = .init(origin: .zero, size: .init(width: 1.0, height: 0.001))
        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: string))
        expected.append(NSAttributedString(attachment: attachment))

        // When
        let result = string.space(.custom(2.0))

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.bounds.size.width, 2.0)
        XCTAssertEqual(resultAttachment.bounds.size.height, 0.001)
    }

    func testAttachmentWithAttributedString() throws {
        // Given
        let image = try AImage.pencil()
        let bounds = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = bounds
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AColor.brown
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = attributedString.attachment(attachment)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.image, image)
        XCTAssertEqual(resultAttachment.bounds, bounds)
        XCTAssertEqual(resultAttributes[.foregroundColor] as? AColor, AColor.brown)
    }

    func testAttachmentWithString() throws {
        // Given
        let image = try AImage.pencil()
        let bounds = CGRect(origin: .zero, size: .init(width: 2, height: 2))
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = bounds

        // When
        let result = string.attachment(attachment)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.image, image)
        XCTAssertEqual(resultAttachment.bounds, bounds)
    }
    #endif

    // MARK: - UIKit/AppKit

    func testBoldWithAttributedStringWithNoFont() throws {
        // Given
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitBold
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .bold
        #endif

        let attributedString = NSAttributedString(string: string)
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: expectedFont])

        // When
        let result = attributedString.bold()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testItalicWithAttributedStringWithExistingFont() throws {
        // Given
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitItalic
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .italic
        #endif

        let font = AFont.preferredFont(forTextStyle: .headline)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: expectedFont])
        let attributedString = NSAttributedString(string: string, attributes: [.font: font])

        // When
        let result = attributedString.italic()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testBoldWithString() throws {
        // Given
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitBold
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .bold
        #endif

        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: expectedFont])

        // When
        let result = string.bold()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testBoldAndItalicAttributedString() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        #if canImport(UIKit)
        let boldTrait: UIFontDescriptor.SymbolicTraits = .traitBold
        let italicTrait: UIFontDescriptor.SymbolicTraits = .traitItalic
        #elseif canImport(AppKit)
        let boldTrait: NSFontDescriptor.SymbolicTraits = .bold
        let italicTrait: NSFontDescriptor.SymbolicTraits = .italic
        #endif

        let attributedString = NSAttributedString(string: string)
        let bold = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([boldTrait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let boldItalic = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(bold.fontDescriptor.withSymbolicTraits([italicTrait, bold.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: boldItalic])

        // When
        let result = attributedString
            .bold()
            .italic()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testBoldAndItalicWithString() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        #if canImport(UIKit)
        let boldTrait: UIFontDescriptor.SymbolicTraits = .traitBold
        let italicTrait: UIFontDescriptor.SymbolicTraits = .traitItalic
        #elseif canImport(AppKit)
        let boldTrait: NSFontDescriptor.SymbolicTraits = .bold
        let italicTrait: NSFontDescriptor.SymbolicTraits = .italic
        #endif

        let bold = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([boldTrait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let boldItalic = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(bold.fontDescriptor.withSymbolicTraits([italicTrait, bold.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: boldItalic])

        // When
        let result = string
            .bold()
            .italic()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testMonospacedWithAttributedString() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitMonoSpace
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .monoSpace
        #endif

        let attributedString = NSAttributedString(string: string, attributes: [.font: font])
        let monospaced = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: monospaced])

        // When
        let result = attributedString.monospaced()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testMonospacedWithString() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitMonoSpace
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .monoSpace
        #endif

        let monospaced = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: monospaced])

        // When
        let result = string.monospaced()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testCondensedWithAttributedString() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitCondensed
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .condensed
        #endif

        let attributedString = NSAttributedString(string: string, attributes: [.font: font])
        let condensed = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: condensed])

        // When
        let result = attributedString.condensed()

        // Then
        XCTAssertEqual(result, expected)
    }

    func testCondensedWithString() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitCondensed
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .condensed
        #endif

        let condensed = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: condensed])

        // When
        let result = string.condensed()

        // Then
        XCTAssertEqual(result, expected)
    }
}
