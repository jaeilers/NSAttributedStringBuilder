import NSAttributedStringBuilder
import Testing
#if canImport(UIKit)
import UIKit
typealias AFontDescriptor = UIFontDescriptor
#elseif canImport(AppKit)
import AppKit
typealias AFontDescriptor = NSFontDescriptor
#endif

@Suite
struct AttributedStringBuildingCoreTests {

    private let string = String.unique()

    // MARK: - Platform independent

    @Test
    func attributeFromStringReturnsNil() {
        // When
        let result: AColor? = String.unique().attribute(.backgroundColor)

        // Then
        #expect(result == nil)
    }

    @Test
    func attributeFromAttributedStringReturnsAttribute() {
        // Given
        let attributedString = NSAttributedString(string: string, attributes: [.backgroundColor: AColor.yellow])

        // When
        let attribute: AColor? = attributedString.attribute(.backgroundColor)

        // Then
        #expect(attribute == AColor.yellow)
    }

    @Test
    func attributeFromAttributedStringAndAttributeDoesNotExistReturnsNil() {
        // Given
        let attributedString = NSAttributedString(string: string, attributes: [.foregroundColor: AColor.black])

        // When
        let attribute: AColor? = attributedString.attribute(.paragraphStyle)

        // Then
        #expect(attribute == nil)
    }

    @Test
    func attributesFromAttributedStringWithUniformAttributes() {
        // Given
        let expected: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .body),
            .foregroundColor: AColor.orange,
            .backgroundColor: AColor.black,
            .kern: NSNumber(value: 1.0)
        ]
        let attributedString = NSAttributedString(string: string, attributes: expected)

        // When
        let attributes = attributedString.attributes()

        // Then
        #expect(NSDictionary(dictionary: attributes) == NSDictionary(dictionary: expected))
    }

    @Test
    func attributesFromAttributedStringWithMixedAttributesReturnsLastCharacterAttributes() {
        // Given
        let expected: Attributes = [
            .foregroundColor: AColor.white,
            .font: AFont.preferredFont(forTextStyle: .footnote)
        ]
        let attributedString = NSMutableAttributedString(
            string: .unique(),
            attributes: [
                .foregroundColor: AColor.red,
                .font: AFont.preferredFont(forTextStyle: .body)
            ]
        )
        attributedString.append(NSAttributedString(string: string, attributes: expected))

        // When
        let attributes = attributedString.attributes()

        // Then
        #expect(NSDictionary(dictionary: attributes) == NSDictionary(dictionary: expected))
    }

    @Test
    func attributesFromEmptyAttributedStringReturnsEmpty() {
        // When
        let attributes = NSAttributedString().attributes()

        // Then
        #expect(attributes.isEmpty)
    }

    @Test
    func attributesFromStringReturnsEmpty() {
        // When
        let attributes = string.attributes()

        // Then
        #expect(attributes.isEmpty)
    }

    @Test
    func mutableParagraphStyleFromAttributedStringReturnsCurrent() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: Attributes = [
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = attributedString.mutableParagraphStyle()

        // Then
        #expect(result == paragraphStyle)
    }

    @Test
    func mutableParagraphStyleFromAttributedStringWithNoParagraphStyle() {
        // Given
        let attributedString = NSAttributedString(string: string)

        // When
        let result = attributedString.mutableParagraphStyle()

        // Then
        #expect(result == NSMutableParagraphStyle())
    }

    @Test
    func mutableParagraphStyleFromStringReturnsEmpty() {
        // When
        let result = string.mutableParagraphStyle()

        // Then
        #expect(result == NSMutableParagraphStyle())
    }

    @Test
    func mutableAttributedStringFromAttributedString() {
        // Given
        let attributedString = NSAttributedString(
            string: string,
            attributes: [
                .font: AFont.preferredFont(forTextStyle: .headline),
                .foregroundColor: AColor.white,
                .baselineOffset: 1.0
            ]
        )

        // When
        let result = attributedString.mutableAttributedString()

        // Then
        #expect(result == attributedString)
    }

    @Test
    func mutableAttributedStringFromString() {
        // When
        let result = string.mutableAttributedString()

        // Then
        #expect(result == NSMutableAttributedString(string: string))
    }

    @Test
    func attributedStringFromAttributedString() {
        // Given
        let attributedString = NSAttributedString(
            string: string,
            attributes: [
                .font: AFont.preferredFont(forTextStyle: .body),
                .foregroundColor: AColor.blue,
                .kern: NSNumber(value: 1.0)
            ]
        )

        // When
        let result = attributedString.attributedString()

        // Then
        #expect(result == attributedString)
    }

    @Test
    func attributedStringFromString() {
        // When
        let result = string.attributedString()

        // Then
        #expect(result == NSAttributedString(string: string))
    }

    @Test
    func addingAttributeToAttributedString() {
        // Given
        let attributedString = NSAttributedString(string: string, attributes: [.foregroundColor: AColor.blue])
        let expected = NSAttributedString(
            string: string,
            attributes: [
                .font: AFont.preferredFont(forTextStyle: .footnote),
                .foregroundColor: AColor.blue
            ]
        )

        // When
        let result = attributedString
            .addingAttribute(.font, value: AFont.preferredFont(forTextStyle: .footnote))

        // Then
        #expect(result == expected)
    }

    @Test
    func addingAttributeToString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.foregroundColor: AColor.red])

        // When
        let result = string.addingAttribute(.foregroundColor, value: AColor.red)

        // Then
        #expect(result == expected)
    }

    @Test
    func addingAttributesToStringWithMultipleAttributes() {
        // Given
        let attributes: Attributes = [
            .foregroundColor: AColor.yellow,
            .font: AFont.preferredFont(forTextStyle: .body),
            .kern: NSNumber(value: 1.0)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = string.addingAttributes(attributes)

        // Then
        #expect(result == expected)
    }

    @Test
    func addingAttributesToAttributedStringWithMultipleAttributes() {
        // Given
        let attributes: Attributes = [
            .foregroundColor: AColor.yellow,
            .font: AFont.preferredFont(forTextStyle: .body),
            .kern: NSNumber(value: 1.0)
        ]
        let expected = NSAttributedString(string: string, attributes: attributes)

        // When
        let result = NSAttributedString(string: string).addingAttributes(attributes)

        // Then
        #expect(result == expected)
    }

    @Test
    func addingAttributesToEmptyAttributedString() {
        // Given
        let attributedString = NSAttributedString()

        // When
        let result = attributedString
            .addingAttributes([.font: AFont.preferredFont(forTextStyle: .body)])
            .attributes()

        // Then
        #expect(result.isEmpty)
    }

    @Test
    func addingStringToAttributedString() {
        // Given
        let expected = NSAttributedString(string: string)

        // When
        let result = NSAttributedString().addingString(string)

        // Then
        #expect(result == expected)
    }

    @Test
    func addingStringToString() {
        // Given
        let newString = String.unique()
        let expected = NSAttributedString(string: string + newString)

        // When
        let result = string.addingString(newString)

        // Then
        #expect(result == expected)
    }

    @Test
    func addingStringWithEmptyString() {
        // Given
        let expected = NSAttributedString(string: string)

        // When
        let result = "".addingString(string)

        // Then
        #expect(result == expected)
    }

    @Test
    func addingStringWhereBothAreEmptyStrings() {
        // When
        let result = "".addingString("")

        // Then
        #expect(result == NSAttributedString())
    }

    @Test
    func addingStringToAttributedStringWithExistingAttributes() {
        // Given
        let newString = String.unique()
        let attributes: Attributes = [
            .foregroundColor: AColor.yellow,
            .font: AFont.preferredFont(forTextStyle: .body)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let expected = NSAttributedString(string: string + newString, attributes: attributes)

        // When
        let result = attributedString.addingString(newString)

        // Then
        #expect(result == expected)
    }

    @Test
    func addingStringToMixedAttributedStringWithAttributes() {
        // Given
        let firstString = String.unique()
        let secondString = String.unique()
        let thirdString = String.unique()
        let first = NSAttributedString(
            string: firstString,
            attributes: [.foregroundColor: AColor.yellow]
        )
        let attributes: Attributes = [
            .foregroundColor: AColor.cyan
        ]
        let second = NSAttributedString(
            string: secondString,
            attributes: attributes
        )
        let combined = NSMutableAttributedString()
        combined.append(first)
        combined.append(second)
        let expected = NSAttributedString(string: firstString + secondString + thirdString, attributes: attributes)

        // When
        let result = combined.addingString(thirdString)

        // Then
        #expect(result == expected)
    }

    @Test
    func addingAttributedStringToAttributedStringAndAttributesAreMerged() {
        // Given
        let newString = String.unique()
        let attributedString = NSAttributedString(
            string: string,
            attributes: [
                .font: AFont.preferredFont(forTextStyle: .body),
                .foregroundColor: AColor.yellow
            ]
        )
        let newAttributedString = NSAttributedString(
            string: newString,
            attributes: [
                .foregroundColor: AColor.red
            ]
        )
        let expected = NSAttributedString(
            string: string + newString,
            attributes: [
                .font: AFont.preferredFont(forTextStyle: .body),
                .foregroundColor: AColor.red
            ]
        )

        // When
        let result = attributedString.addingAttributedString(newAttributedString)

        // Then
        #expect(result == expected)
    }

    @Test
    func addingAttributedStringToStringAndAttributesAreAdded() {
        // Given
        let newString = String.unique()
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .foregroundColor: AColor.blue,
            .backgroundColor: AColor.white
        ]
        let expected = NSAttributedString(string: string + newString, attributes: attributes)

        // When
        let result = string.addingAttributedString(NSAttributedString(string: newString, attributes: attributes))

        // Then
        #expect(result == expected)
    }

    @Test
    func addingAttributedStringToEmptyAttributedString() {
        // When
        let result = NSAttributedString().addingAttributedString(NSAttributedString())

        // Then
        #expect(result == NSAttributedString())
    }

    @Test
    func addingAttributedStringToEmptyString() {
        // When
        let result = "".addingAttributedString(NSAttributedString())

        // Then
        #expect(result == NSAttributedString())
    }

    // MARK: - UIKit/AppKit

    @Test
    func fontWithTraitToAttributedStringWithNoFontAndAddBold() throws {
        // Given
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
        let result = NSAttributedString(string: string).fontWithTrait(trait)

        // Then
        #expect(result == expected)
    }

    @Test
    func fontWithTraitToAttributedStringWithExistingFontAndAddItalic() throws {
        // Given
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
        let attributedString = NSAttributedString(string: string, attributes: [.font: font])

        // When
        let result = attributedString.fontWithTrait(trait)

        // Then
        #expect(result == expected)
    }

    @Test
    func fontWithTraitToStringAndAddBold() throws {
        // Given
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
        let result = string.fontWithTrait(trait)

        // Then
        #expect(result == expected)
    }

    @Test
    func attributedStringAndColorIsChangedResultIsCopied() {
        // Given
        let string1 = String.unique()
            .foregroundColor(.red)
            .font(.boldSystemFont(ofSize: 10))

        let string2 = string1
            .foregroundColor(.blue)

        // Then
        #expect(string1 !== string2)
        #expect(string1 != string2)
    }

    @Test
    func attributedStringConcatStringsResultIsCopied() {
        // Given
        let string1 = String.unique()
            .alignment(.center)
            .backgroundColor(.yellow)

        let string2 = String.unique()
            .foregroundColor(.red)

        // When
        let result = string1.addingAttributedString(string2)

        // Then
        #expect(result !== string1)
        #expect(result != string1)
    }

    // MARK: - All platforms but watchOS

    #if !os(watchOS)
    @Test
    func attributeFromImageReturnsNil() throws {
        // When
        let result: AFont? = try AImage.pencil().attribute(.font)

        // Then
        #expect(result == nil)
    }

    @Test
    func attributesFromImageReturnsEmpty() throws {
        // When
        let attributes = try AImage.pencil().attributes()

        // Then
        #expect(attributes.isEmpty)
    }

    @Test
    func mutableParagraphStyleFromImageReturnsEmpty() throws {
        // When
        let result = try AImage.pencil().mutableParagraphStyle()

        // Then
        #expect(result == NSMutableParagraphStyle())
    }

    @Test
    func mutableAttributedStringFromImage() throws {
        // Given
        let image = try AImage.pencil()

        // When
        let result = image.mutableAttributedString()

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image == image)
    }

    @Test
    func attributedStringFromImage() throws {
        // Given
        let image = try AImage.pencil()

        // When
        let result = image.mutableAttributedString()

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image == image)
    }

    @Test
    func addingAttributeToImage() throws {
        // Given
        let image = try AImage.pencil()

        // When
        let result = image.addingAttribute(.foregroundColor, value: AColor.red)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        #expect(resultAttributes[.foregroundColor] as? AColor == AColor.red)
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image == image)
    }

    @Test
    func addingAttributesToImage() throws {
        // Given
        let attributes: Attributes = [
            .foregroundColor: AColor.blue,
            .backgroundColor: AColor.yellow
        ]
        let image = try AImage.pencil()

        // When
        let result = image.addingAttributes(attributes)

        // Then
        let resultAttributes = result.attributes(at: 0, effectiveRange: nil)
        #expect(resultAttributes[.foregroundColor] as? AColor == AColor.blue)
        #expect(resultAttributes[.backgroundColor] as? AColor == AColor.yellow)
        let resultAttachment = try #require(resultAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image == image)
    }

    @Test
    func addingStringToImage() throws {
        // Given
        let image = try AImage.pencil()

        // When
        let result = image.addingString(string)

        // Then
        let resultImageAttributes = result.attributes(at: 0, effectiveRange: nil)
        let resultAttachment = try #require(resultImageAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image == image)
        let resultString = result.attributedSubstring(from: NSRange(location: 1, length: (string as NSString).length))
        #expect(resultString.string == string)
        let resultStringAttributes = resultString.attributes(at: 0, effectiveRange: nil)
        #expect(resultStringAttributes[.attachment] as? NSTextAttachment == nil)
    }

    @Test
    func addingAttributedStringToImage() throws {
        // Given
        let attributes: Attributes = [
            .font: AFont.preferredFont(forTextStyle: .footnote),
            .foregroundColor: AColor.red,
            .kern: NSNumber(value: 2.0)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let image = try AImage.pencil()

        // When
        let result = image.addingAttributedString(attributedString)

        // Then
        let resultAttributedString = result.attributedSubstring(from: NSRange(location: 1, length: attributedString.length))
        #expect(resultAttributedString == attributedString)

        let resultImageAttributes = result.attributes(at: 0, effectiveRange: nil)
        #expect(resultImageAttributes[.font] as? AFont == AFont.preferredFont(forTextStyle: .footnote))
        #expect(resultImageAttributes[.foregroundColor] as? AColor == AColor.red)
        #expect(resultImageAttributes[.kern] as? NSNumber == NSNumber(value: 2.0))

        let resultAttachment = try #require(resultImageAttributes[.attachment] as? NSTextAttachment)
        #expect(resultAttachment.image == image)
    }

    @Test
    func fontWithTraitToImageAndAddBold() throws {
        // Given
        let image = try AImage.pencil()
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
        let result = image.fontWithTrait(trait)

        // Then
        #expect(result == expected)
    }
    #endif
}
