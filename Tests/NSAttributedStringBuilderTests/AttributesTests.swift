#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif
@testable import NSAttributedStringBuilder
import Testing

@Suite
struct AttributesTests {

    @Test
    func attribute() throws {
        // Given
        let expected = try #require(URL(string: "https://apple.com"))
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: AColor.blue,
            .link: expected as NSURL
        ]

        // When
        let result: URL = try #require(attributes.attribute(.link))

        // Then
        #expect(result == expected)
    }

    @Test
    func attributeWhichDoesNotExist() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: AColor.blue
        ]

        // When
        let result: URL? = attributes.attribute(.link)

        // Then
        #expect(result == nil)
    }

    @Test
    func addingAttributes() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func addingAttributesNewAttributesOverrideExisting() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func addingAttribute() {
        // Given
        let expected: Attributes = [
            .foregroundColor: AColor.purple
        ]

        // When
        let result = Attributes().addingAttribute(.foregroundColor, value: AColor.purple)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func addingAttributeOverridesExistingValue() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
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
        #expect(result == paragraphStyle)
    }

    @Test
    func testMutableParagraphStyleNewParagraphStyleIsReturned() {
        // When
        let result = Attributes().mutableParagraphStyle()

        // Then
        #expect(result == NSMutableParagraphStyle())
    }

    @Test
    func kerning() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func link() throws {
        // Given
        let url = try #require(URL(string: "https://apple.com"))
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func baselineOffset() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func ligature() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func textEffect() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func writingDirection() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func language() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    func languageIdentifier() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    @available(iOS 14, tvOS 14, watchOS 7, *)
    func tracking() {
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
        #expect(result.isEqual(to: expected))
    }

    // MARK: - Platform dependent (typealias)

    @Test
    func font() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func foregroundColor() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func backgroundColor() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func underline() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func underlineDefaultSingle() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func underlineWithColor() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func underlineOverridesExistingColorWithNil() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .underlineColor: AColor.orange
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .underlineStyle: NSNumber(value: NSUnderlineStyle.double.rawValue)
        ]

        // When
        let result = attributes.underline(.double)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func strikethrough() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func strikethroughDefaultIsSingle() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func strikethroughWithColor() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func strikethroughExistingSettingsAreOverridden() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .strikethroughColor: AColor.blue
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.double.rawValue)
        ]

        // When
        let result = attributes.strikethrough(.double)

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func shadowDefaultValues() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func shadowConfigured() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func shadowExistingSettingsAreOverridden() {
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
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .shadow: newShadow
        ]

        // When
        let result = attributes.shadow()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func shadowIsCopiedWhenAttributesAreCopied() {
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
        #expect(!NSDictionary(dictionary: attributes1).isEqual(to: attributes2))
        #expect(NSDictionary(dictionary: attributes1).isEqual(to: expected1))
        #expect(NSDictionary(dictionary: attributes2).isEqual(to: expected2))
    }

    @Test
    func stroke() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func strokeDefaultValues() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func strokeExistingSettingsAreOverridden() {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strokeColor: AColor.orange
        ]
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .strokeWidth: NSNumber(value: 2.0)
        ]

        // When
        let result = attributes.stroke()

        // Then
        #expect(result.isEqual(to: expected))
    }

    @Test
    func paragraphStyle() {
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
        #expect(result.isEqual(to: expected))
    }

    @Test
    func paragraphStylesAreCopiedWhenAttributesAreCopied() {
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
        #expect(!NSDictionary(dictionary: attributes1).isEqual(to: attributes2))
        #expect(NSDictionary(dictionary: attributes1).isEqual(to: expected1))
        #expect(NSDictionary(dictionary: attributes2).isEqual(to: expected2))
    }

    // MARK: - All but watchOS

    #if !os(watchOS)
    @Test
    func attachment() throws {
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
        let resultAttachment = try #require(result[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image == image)
        #expect(resultAttachment.bounds == bounds)
        #expect(result[.foregroundColor] as? AColor == AColor.brown)
    }
    #endif

    // MARK: - UIKit/AppKit

    @Test
    func fontWithTraitWithNoFontAndAddBold() throws {
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitBold
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .bold
        #endif
        let font = AFont.preferredFont(forTextStyle: .body)
        let expected = try AFont(
            descriptor: #require(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )

        // When
        let result = Attributes().fontWithTrait(trait)

        // Then
        #expect(result == expected)
    }

    @Test
    func fontWithTraitWithExistingFontAndAddItalic() throws {
        #if canImport(UIKit)
        let trait: UIFontDescriptor.SymbolicTraits = .traitItalic
        #elseif canImport(AppKit)
        let trait: NSFontDescriptor.SymbolicTraits = .italic
        #endif
        let font = AFont.preferredFont(forTextStyle: .headline)
        let expected = try AFont(
            descriptor: #require(font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        )
        let attributes: Attributes = [
            .font: font
        ]

        // When
        let result = attributes.fontWithTrait(trait)

        // Then
        #expect(result == expected)
    }

    @Test
    func attributeComposition() throws {
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
        #expect(result.isEqual(to: expected))
    }
}
