@testable import NSAttributedStringBuilder
import XCTest

final class AttributesTests: XCTestCase {

    func testAttribute() throws {
        // Given
        let expected = try XCTUnwrap(URL(string: "https://apple.com"))
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: AColor.blue,
            .link: expected as NSURL
        ]

        // When
        let result: URL = try XCTUnwrap(attributes.attribute(.link))

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAttributeWhichDoesNotExist() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: AColor.blue
        ]

        // When
        let result: URL? = attributes.attribute(.link)

        // Then
        XCTAssertNil(result)
    }

    func testAddingAttributes() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .foregroundColor: AColor.brown
        ]
        let newAttributes: Attributes = [
            .kern: NSNumber(value: 1.0)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .foregroundColor: AColor.brown,
            .kern: NSNumber(value: 1.0)
        ]

        // When
        let result = attributes.addingAttributes(newAttributes)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAddingAttributesNewAttributesOverrideExisting() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .foregroundColor: AColor.brown,
            .backgroundColor: AColor.yellow
        ]
        let newAttributes: Attributes = [
            .kern: NSNumber(value: 1.0),
            .backgroundColor: AColor.blue
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .foregroundColor: AColor.brown,
            .backgroundColor: AColor.blue,
            .kern: NSNumber(value: 1.0),
        ]

        // When
        let result = attributes.addingAttributes(newAttributes)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAddingAttribute() {
        // Given
        let expected: Attributes = [
            .foregroundColor: AColor.purple
        ]

        // When
        let result = Attributes().addingAttribute(.foregroundColor, value: AColor.purple)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testAddingAttributeOverridesExistingValue() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .footnote)
        ]

        // When
        let result = attributes.addingAttribute(.font, value: AFont.preferredFont(forTextStyle: .footnote))

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testMutableParagraphStyle() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.hyphenationFactor = 2.0
        let attributes: Attributes = [
            .paragraphStyle: paragraphStyle
        ]

        // When
        let result = attributes.mutableParagraphStyle()

        // Then
        XCTAssertEqual(result, paragraphStyle)
    }

    func testMutableParagraphStyleNewParagraphStyleIsReturned() {
        // When
        let result = Attributes().mutableParagraphStyle()

        // Then
        XCTAssertEqual(result, NSMutableParagraphStyle())
    }

    func testKerning() {
        // Given
        let attributes: Attributes = [
            .kern: NSNumber(value: 1.0),
            .foregroundColor: AColor.yellow
        ]
        let expected: Attributes = [
            .kern: NSNumber(value: 2.0),
            .foregroundColor: AColor.yellow
        ]

        // When
        let result = attributes.kerning(2.0)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testLink() throws {
        // Given
        let url = try XCTUnwrap(URL(string: "https://apple.com"))
        let attributes: Attributes = [
            .foregroundColor: AColor.blue
        ]
        let expected: Attributes = [
            .foregroundColor: AColor.blue,
            .link: url as NSURL
        ]

        // When
        let result = attributes.link(url)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testBaselineOffset() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .baselineOffset: NSNumber(value: 2.0)
        ]

        // When
        let result = attributes.baselineOffset(2.0)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testLigature() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .ligature: NSNumber(value: 0)
        ]

        // When
        let result = attributes.ligature(.none)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testTextEffect() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle as NSString
        ]

        // When
        let result = attributes.textEffect(.letterpressStyle)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testWritingDirection() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .writingDirection: [NSNumber(value: NSWritingDirection.rightToLeft.rawValue | NSWritingDirectionFormatType.embedding.rawValue)]
        ]

        // When
        let result = attributes.writingDirection(.rightToLeftDirectionEmbedding)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testLanguage() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            NSAttributedString.Key(kCTLanguageAttributeName as String): "nl"
        ]

        // When
        let result = attributes.language(.dutch)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    func testLanguageIdentifier() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .languageIdentifier: "de"
        ]

        // When
        let result = attributes.languageIdentifier(.german)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    @available(iOS 14, tvOS 14, watchOS 7, *)
    func testTracking() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .tracking: NSNumber(value: 2.0)
        ]

        // When
        let result = attributes.tracking(2.0)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    // MARK: - Platform dependent (typealias)

    func testFont() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .headline)
        ]

        // When
        let result = attributes.font(.preferredFont(forTextStyle: .headline))

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testForegroundColor() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .foregroundColor: AColor.blue
        ]

        // When
        let result = attributes.foregroundColor(.blue)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testBackgroundColor() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .backgroundColor: AColor.orange
        ]

        // When
        let result = attributes.backgroundColor(.orange)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testUnderline() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .underlineStyle: NSNumber(value: NSUnderlineStyle.double.rawValue)
        ]

        // When
        let result = attributes.underline(.double)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testUnderlineDefaultSingle() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
        ]

        // When
        let result = attributes.underline()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testUnderlineWithColor() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .underlineColor: AColor.orange
        ]

        // When
        let result = attributes.underline(color: .orange)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testUnderlineDoesNotOverrideExistingColorWithNil() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .underlineColor: AColor.orange
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .underlineStyle: NSNumber(value: NSUnderlineStyle.double.rawValue),
            .underlineColor: AColor.orange
        ]

        // When
        let result = attributes.underline(.double)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testStrikethrough() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.double.rawValue)
        ]

        // When
        let result = attributes.strikethrough(.double)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testStrikethroughDefaultIsSingle() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
        ]

        // When
        let result = attributes.strikethrough()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testStrikethroughWithColor() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .strikethroughColor: AColor.blue
        ]

        // When
        let result = attributes.strikethrough(color: .blue)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testStrikethroughDoesNotOverrideExistingColorWithNil() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .strikethroughColor: AColor.blue
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.double.rawValue),
            .strikethroughColor: AColor.blue
        ]

        // When
        let result = attributes.strikethrough(.double)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testShadowDefaultValues() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]

        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        shadow.shadowBlurRadius = 5.0
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .shadow: shadow
        ]

        // When
        let result = attributes.shadow()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testShadowConfigured() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]

        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 5, height: 5)
        shadow.shadowBlurRadius = 1.0
        shadow.shadowColor = AColor.orange
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .shadow: shadow
        ]

        // When
        let result = attributes.shadow(
            offset: .init(width: 5, height: 5),
            blurRadius: 1.0,
            color: .orange
        )

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testShadowExistingColorIsNotOverriddenWithNil() {
        // Given
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 5, height: 5)
        shadow.shadowBlurRadius = 1.0
        shadow.shadowColor = AColor.orange

        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .shadow: shadow
        ]

        let newShadow = NSShadow()
        newShadow.shadowOffset = CGSize(width: 1, height: 1)
        newShadow.shadowBlurRadius = 5.0
        newShadow.shadowColor = AColor.orange
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .shadow: newShadow
        ]

        // When
        let result = attributes.shadow()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testShadowIsCopiedWhenAttributesAreCopied() {
        // Given
        let shadow1 = NSShadow()
        shadow1.shadowOffset = CGSize(width: 1, height: 1)
        shadow1.shadowBlurRadius = 5.0

        let shadow2 = NSShadow()
        shadow2.shadowOffset = .init(width: 3, height: 3)
        shadow2.shadowBlurRadius = 2.0
        shadow2.shadowColor = AColor.yellow

        let expected1: Attributes = [
            .shadow: shadow1
        ]

        let expected2: Attributes = [
            .shadow: shadow2
        ]

        // When
        let attributes1 = Attributes()
            .shadow()

        let attributes2 = attributes1
            .shadow(offset: .init(width: 3, height: 3), blurRadius: 2.0, color: .yellow)

        // Then
        XCTAssertFalse(NSDictionary(dictionary: attributes1).isEqual(to: attributes2))
        XCTAssertTrue(NSDictionary(dictionary: attributes1).isEqual(to: expected1))
        XCTAssertTrue(NSDictionary(dictionary: attributes2).isEqual(to: expected2))
    }

    func testStroke() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strokeWidth: NSNumber(value: 5.0),
            .strokeColor: AColor.purple
        ]

        // When
        let result = attributes.stroke(width: 5.0, color: .purple)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testStrokeDefaultValues() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strokeWidth: NSNumber(value: 2.0)
        ]

        // When
        let result = attributes.stroke()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testStrokeColorIsNotOverridden() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strokeColor: AColor.orange
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strokeWidth: NSNumber(value: 2.0),
            .strokeColor: AColor.orange
        ]

        // When
        let result = attributes.stroke()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testParagraphStyle() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        paragraphStyle.hyphenationFactor = 3.0
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.paragraphSpacing = 2.0

        let expected: Attributes = [
            .paragraphStyle: paragraphStyle
        ]

        // When
        let result = Attributes().paragraphStyle(paragraphStyle)

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }

    func testParagraphStylesAreCopiedWhenAttributesAreCopied() {
        // Given
        let paragraphStyle1 = NSMutableParagraphStyle()
        paragraphStyle1.alignment = .center

        let paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.alignment = .center
        paragraphStyle2.hyphenationFactor = 2.0
        paragraphStyle2.lineBreakMode = .byCharWrapping

        let expected1: Attributes = [
            .paragraphStyle: paragraphStyle1
        ]

        let expected2: Attributes = [
            .paragraphStyle: paragraphStyle2
        ]

        // When
        let attributes1 = Attributes()
            .alignment(.center)

        let attributes2 = attributes1
            .hyphenationFactor(2.0)
            .lineBreakMode(.byCharWrapping)

        // Then
        XCTAssertFalse(NSDictionary(dictionary: attributes1).isEqual(to: attributes2))
        XCTAssertTrue(NSDictionary(dictionary: attributes1).isEqual(to: expected1))
        XCTAssertTrue(NSDictionary(dictionary: attributes2).isEqual(to: expected2))
    }

    // MARK: - All but watchOS

    #if !os(watchOS)
    func testAttachment() throws {
        // Given
        let image = try AImage.pencil()
        let bounds = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = bounds
        let attributes: Attributes = [
            .foregroundColor: AColor.brown
        ]

        // When
        let result = attributes.attachment(attachment)

        // Then
        let resultAttachment = try XCTUnwrap(result[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.image, image)
        XCTAssertEqual(resultAttachment.bounds, bounds)
        XCTAssertEqual(result[.foregroundColor] as? AColor, AColor.brown)
    }
    #endif

    // MARK: - UIKit/AppKit

    func testFontWithTraitWithNoFontAndAddBold() throws {
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitBold
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .bold
        #endif
        let font = AFont.preferredFont(forTextStyle: .body)
        let expected = try AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )


        // When
        let result = Attributes().fontWithTrait(trait)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testFontWithTraitWithExistingFontAndAddItalic() throws {
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitItalic
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .italic
        #endif
        let font = AFont.preferredFont(forTextStyle: .headline)
        let expected = try AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let attributes: Attributes = [
            .font: font
        ]

        // When
        let result = attributes.fontWithTrait(trait)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAttributeComposition() throws {
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
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 12
        paragraphStyle.paragraphSpacing = 13
        paragraphStyle.lineBreakMode = .byTruncatingMiddle
        paragraphStyle.hyphenationFactor = 2.0

        let expected: Attributes = [
            .foregroundColor: AColor.blue,
            .backgroundColor: AColor.yellow,
            NSAttributedString.Key(kCTLanguageAttributeName as String): "de",
            .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .paragraphStyle: paragraphStyle,
            .font: boldItalic
        ]

        // When
        let result = Attributes()
            .font(.preferredFont(forTextStyle: .body))
            .foregroundColor(.blue)
            .backgroundColor(.yellow)
            .language(.german)
            .underline()
            .alignment(.center)
            .lineSpacing(12)
            .paragraphSpacing(13)
            .lineBreakMode(.byTruncatingMiddle)
            .hyphenationFactor(2.0)
            .bold()
            .italic()

        // Then
        XCTAssertTrue(result.isEqual(to: expected))
    }
}
