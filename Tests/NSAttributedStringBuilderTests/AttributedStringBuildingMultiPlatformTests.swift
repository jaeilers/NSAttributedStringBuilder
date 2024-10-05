import NSAttributedStringBuilder
import Testing
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

@Suite
struct AttributedStringBuildingMultiPlatformTests {

    private let string = String.unique()

    // MARK: - Platform independent

    @Test
    func textWithAttributedString() {
        // Given
        let newString = String.unique()
        let attributes: Attributes = [
            .foregroundColor: AColor.yellow
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + newString, attributes: attributes)

        // When
        let result = attributedString.text(newString)

        // Then
        #expect(result == expected)
    }

    @Test
    func textWithString() {
        // Given
        let newString = String.unique()
        let expected = NSAttributedString(string: string + newString)

        // When
        let result = string.text(newString)

        // Then
        #expect(result == expected)
    }

    @Test
    func kerningWithAttributedString() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .headline)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expectedAttributes = attributes.merging([.kern: NSNumber(value: 1.0)], uniquingKeysWith: { _, new in new })
        let expected = NSAttributedString(string: string, attributes: expectedAttributes)

        // When
        let result = attributedString.kerning(1.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func kerningWithString() {
        // Given
        let attributes: Attributes = [
            .kern: NSNumber(value: 1.0)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.kerning(1.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func spaceWithAttributedStringAndStandardSpace() {
        // Given
        let attributes: Attributes = [
            .baselineOffset: NSNumber(value: 1)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + " ", attributes: attributes)

        // When
        let result = attributedString.space()

        // Then
        #expect(result == expected)
    }

    @Test
    func spaceWithStringAndStandardSpace() {
        // Given
        let expected = NSAttributedString(string: string + " ")

        // When
        let result = string.space()

        // Then
        #expect(result == expected)
    }

    @Test
    func spaceWithAttributedStringAndENSpace() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .footnote)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + "\u{2002}", attributes: attributes)

        // When
        let result = attributedString.space(.enSpace)

        // Then
        #expect(result == expected)
    }

    @Test
    func spaceWithStringAndENSpace() {
        // Given
        let expected = NSAttributedString(string: string + "\u{2002}")

        // When
        let result = string.space(.enSpace)

        // Then
        #expect(result == expected)
    }

    @Test
    func spaceWithAttributedStringAndEMSpace() {
        // Given
        let attributes: Attributes = [
            .backgroundColor: AColor.brown
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + "\u{2003}", attributes: attributes)

        // When
        let result = attributedString.space(.emSpace)

        // Then
        #expect(result == expected)
    }

    @Test
    func spaceWithStringAndEMSpace() {
        // Given
        let expected = NSAttributedString(string: string + "\u{2003}")

        // When
        let result = string.space(.emSpace)

        // Then
        #expect(result == expected)
    }

    @Test
    func nonBreakingSpaceWithAttributedString() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .foregroundColor: AColor.blue
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + "\u{00A0}", attributes: attributes)

        // When
        let result = attributedString.nonBreakingSpace()

        // Then
        #expect(result == expected)
    }

    @Test
    func nonBreakingSpaceWithString() {
        // Given
        let expected = NSAttributedString(string: string + "\u{00A0}")

        // When
        let result = string.nonBreakingSpace()

        // Then
        #expect(result == expected)
    }

    @Test
    func narrowNonBreakingSpaceWithAttributedString() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .foregroundColor: AColor.blue
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + "\u{202F}", attributes: attributes)

        // When
        let result = attributedString.space(.narrowNonBreakingSpace)

        // Then
        #expect(result == expected)
    }

    @Test
    func narrowNonBreakingSpaceWithString() {
        // Given
        let expected = NSAttributedString(string: string + "\u{202F}")

        // When
        let result = string.space(.narrowNonBreakingSpace)

        // Then
        #expect(result == expected)
    }

    @Test
    func newlineWithAttributedString() {
        // Given
        let attributes: Attributes = [
            .backgroundColor: AColor.black
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + "\n", attributes: attributes)

        // When
        let result = attributedString.newline()

        // Then
        #expect(result == expected)
    }

    @Test
    func newlineWithString() {
        // Given
        let expected = NSAttributedString(string: string + "\n")

        // When
        let result = string.newline()

        // Then
        #expect(result == expected)
    }

    @Test
    func linkWithAttributedString() throws {
        // Given
        let url = try #require(URL(string: "https://apple.com"))
        let attributes: Attributes = [
            .backgroundColor: AColor.yellow
        ]
        let expectedAttributes = attributes.merging([.link: url as NSURL], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: expectedAttributes)

        // When
        let result = attributedString.link(url)

        // Then
        #expect(result == expected)
    }

    @Test
    func linkWithString() throws {
        // Given
        let url = try #require(URL(string: "https://apple.com"))
        let attributes: Attributes = [
            .link: url as NSURL
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.link(url)

        // Then
        #expect(result == expected)
    }

    @Test
    func baselineOffsetWithAttributedString() {
        // Given
        let attributes: Attributes = [
            .foregroundColor: AColor.lightGray
        ]
        let newAttributes = attributes.merging([.baselineOffset: NSNumber(value: 2.0)], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.baselineOffset(2.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func baselineOffsetWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.baselineOffset: NSNumber(value: 2.0)])

        // When
        let result = string.baselineOffset(2.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func ligatureWithAttributedStringAndNoLigature() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .caption1)
        ]
        let newAttributes = attributes.merging([.ligature: NSNumber(value: 0)], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.ligature(.none)

        // Then
        #expect(result == expected)
    }

    @Test
    func ligatureWithStringAndNoLigature() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.ligature: NSNumber(value: 0)])

        // When
        let result = string.ligature(.none)

        // Then
        #expect(result == expected)
    }

    @Test
    func ligatureWithAttributedStringAndDefaultLigatures() {
        // Given
        let attributes: Attributes = [
            .kern: NSNumber(value: 5.0)
        ]
        let newAttributes = attributes.merging([.ligature: NSNumber(value: 1)], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.ligature(.default)

        // Then
        #expect(result == expected)
    }

    @Test
    func ligatureWithStringAndDefaultLigatures() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.ligature: NSNumber(value: 1)])

        // When
        let result = string.ligature(.default)

        // Then
        #expect(result == expected)
    }

    @Test
    func textEffectWithAttributedStringAndLetterpressStyle() {
        // Given
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func textEffectWithStringAndLetterpressStyle() {
        // Given
        let expected = NSAttributedString(
            string: string,
            attributes: [.textEffect: NSAttributedString.TextEffectStyle.letterpressStyle as NSString]
        )

        // When
        let result = string.textEffect(.letterpressStyle)

        // Then
        #expect(result == expected)
    }

    @Test
    func writingDirectionWithAttributedStringAndLeftToRightEmbedding() {
        // Given
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func writingDirectionWithStringAndLeftToRightEmbedding() {
        // Given
        let expected = NSAttributedString(
            string: string,
            attributes: [.writingDirection: [NSWritingDirection.leftToRight.rawValue | NSWritingDirectionFormatType.embedding.rawValue]]
        )

        // When
        let result = string.writingDirection(.leftToRightDirectionEmbedding)

        // Then
        #expect(result == expected)
    }

    @Test
    func writingDirectionWithAttributedStringAndLeftToRightOverride() {
        // Given
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func writingDirectionWithStringAndLeftToRightOverride() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.writingDirection: [NSWritingDirection.leftToRight.rawValue | NSWritingDirectionFormatType.override.rawValue]])

        // When
        let result = string.writingDirection(.leftToRightDirectionOverride)

        // Then
        #expect(result == expected)
    }

    @Test
    func writingDirectionWithAttributedStringAndRightToLeftEmbedding() {
        // Given
        let attributes: Attributes = [
            .foregroundColor: AColor.blue
        ]
        let newAttributes = attributes.merging([.writingDirection: [NSWritingDirection.rightToLeft.rawValue | NSWritingDirectionFormatType.embedding.rawValue]], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.writingDirection(.rightToLeftDirectionEmbedding)

        // Then
        #expect(result == expected)
    }

    @Test
    func writingDirectionWithStringAndRightToLeftEmbedding() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.writingDirection: [NSWritingDirection.rightToLeft.rawValue | NSWritingDirectionFormatType.embedding.rawValue]])

        // When
        let result = string.writingDirection(.rightToLeftDirectionEmbedding)

        // Then
        #expect(result == expected)
    }

    @Test
    func writingDirectionWithAttributedStringAndRightToLeftOverride() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .headline)
        ]
        let newAttributes = attributes.merging([.writingDirection: [NSWritingDirection.rightToLeft.rawValue | NSWritingDirectionFormatType.override.rawValue]], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.writingDirection(.rightToLeftDirectionOverride)

        // Then
        #expect(result == expected)
    }

    @Test
    func writingDirectionWithStringAndRightToLeftOverride() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.writingDirection: [NSWritingDirection.rightToLeft.rawValue | NSWritingDirectionFormatType.override.rawValue]])

        // When
        let result = string.writingDirection(.rightToLeftDirectionOverride)

        // Then
        #expect(result == expected)
    }

    @Test
    func languageWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    func languageIdentifierWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [NSAttributedString.Key(String(kCTLanguageAttributeName)): "de"])

        // When
        let result = string.language(.german)

        // Then
        #expect(result == expected)
    }

    @Test
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    func languageIdentifierWithLanguageCodeAndAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    func languageIdentifierWithLanguageIdentifierAndString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.languageIdentifier: "fr"])

        // When
        let result = string.languageIdentifier(.french)

        // Then
        #expect(result == expected)
    }

    @Test
    @available(iOS 14, tvOS 14, watchOS 7, *)
    func trackingWithAttributedString() {
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
        #expect(result == expected)
    }

    @Test
    @available(iOS 14, tvOS 14, watchOS 7, *)
    func trackingWithString() {
        // Given
        let attributes: Attributes = [
            .tracking: NSNumber(value: 5)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.tracking(5)

        // Then
        #expect(result == expected)
    }

    // MARK: - Paragraph Styles

    @Test
    func paragraphStyleWithAttributedString() {
        // Given
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func paragraphStyleWithString() {
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
        #expect(result == expected)
    }

    @Test
    func paragraphStyleWithAttributedStringOverrideExistingParagraphStyle() {
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
        #expect(result == expected)
    }

    @Test
    func alignmentWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 2.0
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func alignmentWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.alignment(.center)

        // Then
        #expect(result == expected)
    }

    @Test
    func firstLineHeadIndentWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func firstLineHeadIndentWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 42.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.firstLineHeadIndent(42.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func headIndentWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func headIndentWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 1.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.headIndent(1.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func tailIndentWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func tailIndentWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tailIndent = 2.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.tailIndent(2.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func lineHeightMultipleWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func lineHeightMultipleWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 4.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.lineHeightMultiple(4.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func maximumLineHeightWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20.0
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func maximumLineHeightWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = 10.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.maximumLineHeight(10.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func minimumLineHeightWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8.0
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func minimumLineHeightWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 3.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.minimumLineHeight(3.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func lineSpacingWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func lineSpacingWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.lineSpacing(1.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func paragraphSpacingWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func paragraphSpacingWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 4.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.paragraphSpacing(4.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func paragraphSpacingBeforeWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func paragraphSpacingBeforeWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacingBefore = 1.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.paragraphSpacingBefore(1.0)

        // Then
        #expect(result == expected)
    }

    @Test
    func lineBreakModeWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.0
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func lineBreakModeWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.lineBreakMode(.byWordWrapping)

        // Then
        #expect(result == expected)
    }

    @Test
    func lineBreakStrategyWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 2.0
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func lineBreakStrategyWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakStrategy = .pushOut
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.lineBreakStrategy(.pushOut)

        // Then
        #expect(result == expected)
    }

    @Test
    func hyphenationFactorWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func hyphenationFactorWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 1.0
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.hyphenationFactor(1.0)

        // Then
        #expect(result == expected)
    }

    @Test
    @available(iOS 15, macOS 13, watchOS 8, tvOS 15, *)
    func usesDefaultHyphenationWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    @available(iOS 15, macOS 13, watchOS 8, tvOS 15, *)
    func usesDefaultHyphenationWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.usesDefaultHyphenation = false
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.usesDefaultHyphenation(false)

        // Then
        #expect(result == expected)
    }

    @Test
    func allowsDefaultTighteningForTruncationWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func allowsDefaultTighteningForTruncationWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.allowsDefaultTighteningForTruncation = false
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.allowsDefaultTighteningForTruncation(false)

        // Then
        #expect(result == expected)
    }

    @Test
    func baseWritingDirectionWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func baseWritingDirectionWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.baseWritingDirection = .rightToLeft
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.baseWritingDirection(.rightToLeft)

        // Then
        #expect(result == expected)
    }

    @Test
    func tabStopsWithAttributedString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func tabStopsWithString() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .center, location: 0)]
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])

        // When
        let result = string.tabStops([NSTextTab(textAlignment: .center, location: 0)])

        // Then
        #expect(result == expected)
    }

    @Test
    func multipleParagraphStylesWithAttributedStringAndExistingParagraphStyle() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 13.0
        let attributes: Attributes = [
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let newParagraphStyle = NSMutableParagraphStyle()
        newParagraphStyle.hyphenationFactor = 1.0
        newParagraphStyle.lineSpacing = 2.0
        newParagraphStyle.paragraphSpacing = 3.0
        newParagraphStyle.lineBreakMode = .byWordWrapping
        newParagraphStyle.alignment = .center
        let newAttributes: Attributes = [
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
        #expect(result == expected)
    }

    // MARK: - Platform dependent (typealias)

    @Test
    func fontWithAttributedStringOverridesExistingFont() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .footnote)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: [.font: AFont.preferredFont(forTextStyle: .headline)])

        // When
        let result = attributedString.font(AFont.preferredFont(forTextStyle: .headline))

        // Then
        #expect(result == expected)
    }

    @Test
    func fontWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.font: AFont.preferredFont(forTextStyle: .caption1)])

        // When
        let result = string.font(AFont.preferredFont(forTextStyle: .caption1))

        // Then
        #expect(result == expected)
    }

    @Test
    func foregroundColorWithAttributedStringOverridesExistingColor() {
        // Given
        let attributes: Attributes = [
            .foregroundColor: AColor.black
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: [.foregroundColor: AColor.yellow])

        // When
        let result = attributedString.foregroundColor(AColor.yellow)

        // Then
        #expect(result == expected)
    }

    @Test
    func foregroundColorWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.foregroundColor: AColor.cyan])

        // When
        let result = string.foregroundColor(AColor.cyan)

        // Then
        #expect(result == expected)
    }

    @Test
    func backgroundColorWithAttributedStringOverridesExistingColor() {
        // Given
        let attributes: Attributes = [
            .backgroundColor: AColor.yellow
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: [.backgroundColor: AColor.blue])

        // When
        let result = attributedString.backgroundColor(AColor.blue)

        // Then
        #expect(result == expected)
    }

    @Test
    func backgroundColorWithString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.backgroundColor: AColor.cyan])

        // When
        let result = string.backgroundColor(AColor.cyan)

        // Then
        #expect(result == expected)
    }

    @Test
    func underlineStyleWithAttributedStringOverridesExistingValue() {
        // Given
        let attributes: Attributes = [
            .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: [.underlineStyle: NSNumber(value: NSUnderlineStyle.double.rawValue)])

        // When
        let result = attributedString.underline(.double)

        // Then
        #expect(result == expected)
    }

    @Test
    func underlineStyleWithAttributedStringAndUnderlineColorOverridesExistingValues() {
        // Given
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func underlineStyleWithAttributedStringAndUnderlineColorNoColorDoesNotResetExistingValue() {
        // Given
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func underlineStyleWithString() {
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
        #expect(result == expected)
    }

    @Test
    func underlineStyleWithStringAndUnderlineColor() {
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
        #expect(result == expected)
    }

    @Test
    func strikethroughWithAttributedStringOverridesExistingValue() {
        // Given
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func strikethroughWithAttributedStringAndColorOverridesExistingValues() {
        // Given
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func strikethroughWithAttributedStringAndNoColorDoesNotOverrideExistingValue() {
        // Given
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func strikethroughWithString() {
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
        #expect(result == expected)
    }

    @Test
    func strikethroughWithStringAndUnderlineColor() {
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
        #expect(result == expected)
    }

    @Test
    func shadowWithAttributedStringDefaultValuesAreAppliedAndOverrideExistingValues() {
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
        #expect(result == expected)
    }

    @Test
    func shadowWithAttributedStringAndColor() {
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
        #expect(result == expected)
    }

    @Test
    func shadowWithAttributedStringExistingShadowIsOverridden() {
        // Given
        let shadow = NSShadow()
        shadow.shadowOffset = .init(width: 5, height: 5)
        shadow.shadowBlurRadius = 10.0
        shadow.shadowColor = AColor.red
        let attributedString = NSAttributedString(string: string, attributes: [.shadow: shadow])
        let newShadow = NSShadow()
        newShadow.shadowOffset = .init(width: 10, height: 10)
        newShadow.shadowBlurRadius = 1.0
        let expected = NSAttributedString(string: string, attributes: [.shadow: newShadow])

        // When
        let result = attributedString.shadow(
            offset: .init(width: 10, height: 10),
            blurRadius: 1,
            color: nil
        )

        // Then
        #expect(result == expected)
    }

    @Test
    func shadowWithString() {
        // Given
        let shadow = NSShadow()
        shadow.shadowOffset = .init(width: 1, height: 1)
        shadow.shadowBlurRadius = 5.0
        let expected = NSAttributedString(string: string, attributes: [.shadow: shadow])

        // When
        let result = string.shadow()

        // Then
        #expect(result == expected)
    }

    @Test
    func shadowWithStringAndColor() {
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
        #expect(result == expected)
    }

    @Test
    func strokeWithAttributedStringOverridesExistingValueAndDefaultValueIsApplied() {
        // Given
        let attributes: Attributes = [
            .strokeWidth: NSNumber(value: 10)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: [.strokeWidth: NSNumber(value: 2.0)])

        // When
        let result = attributedString.stroke()

        // Then
        #expect(result == expected)
    }

    @Test
    func strokeWithAttributedStringAndColorOverridesExistingValues() {
        // Given
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    @Test
    func strokeWithAttributedStringNoColorDoesNotOverrideExistingColor() {
        // Given
        let attributes: Attributes = [
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
        #expect(result == expected)
    }

    // MARK: - All platforms but iOS

    #if !os(iOS)
    @Test
    func ligatureWithAttributedStringAndAllLigatures() {
        // Given
        let attributes: Attributes = [
            .baselineOffset: NSNumber(value: 13)
        ]
        let newAttributes = attributes.merging([.ligature: NSNumber(value: 2)], uniquingKeysWith: { _, new in new })
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string, attributes: newAttributes)

        // When
        let result = attributedString.ligature(.all)

        // Then
        #expect(result == expected)
    }

    @Test
    func ligatureWithStringAndAllLigatures() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.ligature: NSNumber(value: 2)])

        // When
        let result = string.ligature(.all)

        // Then
        #expect(result == expected)
    }
    #endif

    // MARK: - All platforms but watchOS

    #if !os(watchOS)
    @Test
    func spaceWithAttributedStringAndCustomSpace() throws {
        // Given
        let attributes: Attributes = [
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
        #expect(resultAttributes[.foregroundColor] as? AColor == AColor.red)
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.bounds.size.width == 1.0)
        #expect(resultAttachment.bounds.size.height == 0.001)
    }

    @Test
    func spaceWithStringAndCustomSpace() throws {
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
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.bounds.size.width == 2.0)
        #expect(resultAttachment.bounds.size.height == 0.001)
    }

    @Test
    func attachmentWithAttributedString() throws {
        // Given
        let image = try AImage.pencil()
        let bounds = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = bounds
        let attributes: Attributes = [
            .foregroundColor: AColor.brown
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = attributedString.attachment(attachment)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image == image)
        #expect(resultAttachment.bounds == bounds)
        #expect(resultAttributes[.foregroundColor] as? AColor == AColor.brown)
    }

    @Test
    func attachmentWithString() throws {
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
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image == image)
        #expect(resultAttachment.bounds == bounds)
    }
    #endif

    // MARK: - UIKit/AppKit

    @Test
    func boldWithAttributedStringWithNoFont() throws {
        // Given
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitBold
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .bold
        #endif

        let attributedString = NSAttributedString(string: string)
        let font = AFont.preferredFont(forTextStyle: .body)
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits]))
        let expectedFont = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: expectedFont])

        // When
        let result = attributedString.bold()

        // Then
        #expect(result == expected)
    }

    @Test
    func italicWithAttributedStringWithExistingFont() throws {
        // Given
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitItalic
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .italic
        #endif

        let font = AFont.preferredFont(forTextStyle: .headline)
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits]))
        let expectedFont = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: expectedFont])
        let attributedString = NSAttributedString(string: string, attributes: [.font: font])

        // When
        let result = attributedString.italic()

        // Then
        #expect(result == expected)
    }

    @Test
    func boldWithString() throws {
        // Given
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitBold
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .bold
        #endif

        let font = AFont.preferredFont(forTextStyle: .body)
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits]))
        let expectedFont = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: expectedFont])

        // When
        let result = string.bold()

        // Then
        #expect(result == expected)
    }

    @Test
    func boldAndItalicAttributedString() throws {
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
        let boldDescriptor = try #require(font.fontDescriptor.withSymbolicTraits([boldTrait, font.fontDescriptor.symbolicTraits]))
        let bold = try #require(AFont(
            descriptor: boldDescriptor,
            size: 0.0
        ))
        let boldItalicDescriptor = try #require(bold.fontDescriptor.withSymbolicTraits([italicTrait, bold.fontDescriptor.symbolicTraits]))
        let boldItalic = try #require(AFont(
            descriptor: boldItalicDescriptor,
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: boldItalic])

        // When
        let result = attributedString
            .bold()
            .italic()

        // Then
        #expect(result == expected)
    }

    @Test
    func boldAndItalicWithString() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        #if canImport(UIKit)
        let boldTrait: UIFontDescriptor.SymbolicTraits = .traitBold
        let italicTrait: UIFontDescriptor.SymbolicTraits = .traitItalic
        #elseif canImport(AppKit)
        let boldTrait: NSFontDescriptor.SymbolicTraits = .bold
        let italicTrait: NSFontDescriptor.SymbolicTraits = .italic
        #endif

        let boldDescriptor = try #require(font.fontDescriptor.withSymbolicTraits([boldTrait, font.fontDescriptor.symbolicTraits]))
        let bold = try #require(AFont(
            descriptor: boldDescriptor,
            size: 0.0
        ))
        let boldItalicDescriptor = try #require(bold.fontDescriptor.withSymbolicTraits([italicTrait, bold.fontDescriptor.symbolicTraits]))
        let boldItalic = try #require(AFont(
            descriptor: boldItalicDescriptor,
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: boldItalic])

        // When
        let result = string
            .bold()
            .italic()

        // Then
        #expect(result == expected)
    }

    @Test
    func monospacedWithAttributedString() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitMonoSpace
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .monoSpace
        #endif

        let attributedString = NSAttributedString(string: string, attributes: [.font: font])
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits]))
        let monospaced = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: monospaced])

        // When
        let result = attributedString.monospaced()

        // Then
        #expect(result == expected)
    }

    @Test
    func monospacedWithString() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitMonoSpace
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .monoSpace
        #endif

        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits]))
        let monospaced = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: monospaced])

        // When
        let result = string.monospaced()

        // Then
        #expect(result == expected)
    }

    @Test
    func condensedWithAttributedString() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitCondensed
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .condensed
        #endif

        let attributedString = NSAttributedString(string: string, attributes: [.font: font])
        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits]))
        let condensed = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: condensed])

        // When
        let result = attributedString.condensed()

        // Then
        #expect(result == expected)
    }

    @Test
    func condensedWithString() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitCondensed
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .condensed
        #endif

        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits]))
        let condensed = try #require(AFont(
            descriptor: descriptor,
            size: 0.0
        ))
        let expected = NSAttributedString(string: string, attributes: [.font: condensed])

        // When
        let result = string.condensed()

        // Then
        #expect(result == expected)
    }
}
