import NSAttributedStringBuilder
import XCTest
#if canImport(UIKit)
typealias AFontDescriptor = UIFontDescriptor
#elseif canImport(AppKit)
typealias AFontDescriptor = NSFontDescriptor
#endif

final class AttributedStringBuildingCoreTests: XCTestCase {

    private let string = String.unique()

    // MARK: - Platform independent

    func testAttributeFromStringReturnsNil() {
        // When
        let result: AColor? = String.unique().attribute(.backgroundColor)

        // Then
        XCTAssertNil(result)
    }

    func testAttributeFromAttributedStringReturnsAttribute() {
        // Given
        let attributedString = NSAttributedString(string: string, attributes: [.backgroundColor: AColor.yellow])

        // When
        let attribute: AColor? = attributedString.attribute(.backgroundColor)

        // Then
        XCTAssertEqual(attribute, AColor.yellow)
    }

    func testAttributeFromAttributedStringAndAttributeDoesNotExistReturnsNil() {
        // Given
        let attributedString = NSAttributedString(string: string, attributes: [.foregroundColor: AColor.black])

        // When
        let attribute: AColor? = attributedString.attribute(.paragraphStyle)

        // Then
        XCTAssertNil(attribute)
    }

    func testAttributesFromAttributedStringWithUniformAttributes() {
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
        XCTAssertEqual(NSDictionary(dictionary: attributes), NSDictionary(dictionary: expected))
    }

    func testAttributesFromAttributedStringWithMixedAttributesReturnsLastCharacterAttributes() {
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
        XCTAssertEqual(NSDictionary(dictionary: attributes), NSDictionary(dictionary: expected))
    }

    func testAttributesFromEmptyAttributedStringReturnsEmpty() {
        // When
        let attributes = NSAttributedString().attributes()

        // Then
        XCTAssertTrue(attributes.isEmpty)
    }

    func testAttributesFromStringReturnsEmpty() {
        // When
        let attributes = string.attributes()

        // Then
        XCTAssertTrue(attributes.isEmpty)
    }

    func testMutableParagraphStyleFromAttributedStringReturnsCurrent() {
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
        XCTAssertEqual(result, paragraphStyle)
    }

    func testMutableParagraphStyleFromAttributedStringWithNoParagraphStyle() {
        // Given
        let attributedString = NSAttributedString(string: string)

        // When
        let result = attributedString.mutableParagraphStyle()

        // Then
        XCTAssertEqual(result, NSMutableParagraphStyle())
    }

    func testMutableParagraphStyleFromStringReturnsEmpty() {
        // When
        let result = string.mutableParagraphStyle()

        // Then
        XCTAssertEqual(result, NSMutableParagraphStyle())
    }

    func testMutableAttributedStringFromAttributedString() {
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
        XCTAssertEqual(result, attributedString)
    }

    func testMutableAttributedStringFromString() {
        // When
        let result = string.mutableAttributedString()

        // Then
        XCTAssertEqual(result, NSMutableAttributedString(string: string))
    }

    func testAttributedStringFromAttributedString() {
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
        XCTAssertEqual(result, attributedString)
    }

    func testAttributedStringFromString() {
        // When
        let result = string.attributedString()

        // Then
        XCTAssertEqual(result, NSAttributedString(string: string))
    }

    func testAddingAttributeToAttributedString() {
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
        XCTAssertEqual(result, expected)
    }

    func testAddingAttributeToString() {
        // Given
        let expected = NSAttributedString(string: string, attributes: [.foregroundColor: AColor.red])

        // When
        let result = string.addingAttribute(.foregroundColor, value: AColor.red)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAddingAttributesToStringWithMultipleAttributes() {
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
        XCTAssertEqual(result, expected)
    }

    func testAddingAttributesToAttributedStringWithMultipleAttributes() {
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
        XCTAssertEqual(result, expected)
    }

    func testAddingAttributesToEmptyAttributedString() {
        // Given
        let attributedString = NSAttributedString()

        // When
        let result = attributedString
            .addingAttributes([.font: AFont.preferredFont(forTextStyle: .body)])
            .attributes()

        // Then
        XCTAssertTrue(result.isEmpty)
    }

    func testAddingStringToAttributedString() {
        // Given
        let expected = NSAttributedString(string: string)

        // When
        let result = NSAttributedString().addingString(string)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAddingStringToString() {
        // Given
        let newString = String.unique()
        let expected = NSAttributedString(string: string + newString)

        // When
        let result = string.addingString(newString)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAddingStringWithEmptyString() {
        // Given
        let expected = NSAttributedString(string: string)

        // When
        let result = "".addingString(string)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAddingStringWhereBothAreEmptyStrings() {
        // When
        let result = "".addingString("")

        // Then
        XCTAssertEqual(result, NSAttributedString())
    }

    func testAddingStringToAttributedStringWithExistingAttributes() {
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
        XCTAssertEqual(result, expected)
    }

    func testAddingStringToMixedAttributedStringWithAttributes() {
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
        XCTAssertEqual(result, expected)
    }

    func testAddingAttributedStringToAttributedStringAndAttributesAreMerged() {
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
        XCTAssertEqual(result, expected)
    }

    func testAddingAttributedStringToStringAndAttributesAreAdded() {
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
        XCTAssertEqual(result, expected)
    }

    func testAddingAttributedStringToEmptyAttributedString() {
        // When
        let result = NSAttributedString().addingAttributedString(NSAttributedString())

        // Then
        XCTAssertEqual(result, NSAttributedString())
    }

    func testAddingAttributedStringToEmptyString() {
        // When
        let result = "".addingAttributedString(NSAttributedString())

        // Then
        XCTAssertEqual(result, NSAttributedString())
    }

    // MARK: - UIKit/AppKit

    func testFontWithTraitToAttributedStringWithNoFontAndAddBold() throws {
        // Given
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
        let result = NSAttributedString(string: string).fontWithTrait(trait)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testFontWithTraitToAttributedStringWithExistingFontAndAddItalic() throws {
        // Given
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
        let attributedString = NSAttributedString(string: string, attributes: [.font: font])

        // When
        let result = attributedString.fontWithTrait(trait)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testFontWithTraitToStringAndAddBold() throws {
        // Given
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
        let result = string.fontWithTrait(trait)

        // Then
        XCTAssertEqual(result, expected)
    }

    func testAttributedStringAndColorIsChangedResultIsCopied() {
        // Given
        let string1 = String.unique()
            .foregroundColor(.red)
            .font(.boldSystemFont(ofSize: 10))

        let string2 = string1
            .foregroundColor(.blue)

        // Then
        XCTAssertFalse(string1 === string2)
        XCTAssertFalse(string1 == string2)
    }

    func testAttributedStringConcatStringsResultIsCopied() {
        // Given
        let string1 = String.unique()
            .alignment(.center)
            .backgroundColor(.yellow)

        let string2 = String.unique()
            .foregroundColor(.red)

        // When
        let result = string1.addingAttributedString(string2)

        // Then
        XCTAssertFalse(result === string1)
        XCTAssertFalse(result == string1)
    }

    // MARK: - All platforms but watchOS

    #if !os(watchOS)
    func testAttributeFromImageReturnsNil() throws {
        // When
        let result: AFont? = try AImage.pencil().attribute(.font)

        // Then
        XCTAssertNil(result)
    }

    func testAttributesFromImageReturnsEmpty() throws {
        // When
        let attributes = try AImage.pencil().attributes()

        // Then
        XCTAssertTrue(attributes.isEmpty)
    }

    func testMutableParagraphStyleFromImageReturnsEmpty() throws {
        // When
        let result = try AImage.pencil().mutableParagraphStyle()

        // Then
        XCTAssertEqual(result, NSMutableParagraphStyle())
    }

    func testMutableAttributedStringFromImage() throws {
        // Given
        let image = try AImage.pencil()

        // When
        let result = image.mutableAttributedString()

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.image, image)
    }

    func testAttributedStringFromImage() throws {
        // Given
        let image = try AImage.pencil()

        // When
        let result = image.mutableAttributedString()

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.image, image)
    }

    func testAddingAttributeToImage() throws {
        // Given
        let image = try AImage.pencil()

        // When
        let result = image.addingAttribute(.foregroundColor, value: AColor.red)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        XCTAssertEqual(resultAttributes[.foregroundColor] as? AColor, AColor.red)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.image, image)
    }

    func testAddingAttributesToImage() throws {
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
        XCTAssertEqual(resultAttributes[.foregroundColor] as? AColor, AColor.blue)
        XCTAssertEqual(resultAttributes[.backgroundColor] as? AColor, AColor.yellow)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.image, image)
    }

    func testAddingStringToImage() throws {
        // Given
        let image = try AImage.pencil()

        // When
        let result = image.addingString(string)

        // Then
        let resultImageAttributes = result.attributes(at: 0, effectiveRange: nil)
        let resultAttachment = try XCTUnwrap(resultImageAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.image, image)
        let resultString = result.attributedSubstring(from: NSRange(location: 1, length: (string as NSString).length))
        XCTAssertEqual(resultString.string, string)
        let resultStringAttributes = resultString.attributes(at: 0, effectiveRange: nil)
        XCTAssertNil(resultStringAttributes[.attachment] as? NSTextAttachment)
    }

    func testAddingAttributedStringToImage() throws {
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
        XCTAssertEqual(resultAttributedString, attributedString)

        let resultImageAttributes = result.attributes(at: 0, effectiveRange: nil)
        XCTAssertEqual(resultImageAttributes[.font] as? AFont, AFont.preferredFont(forTextStyle: .footnote))
        XCTAssertEqual(resultImageAttributes[.foregroundColor] as? AColor, AColor.red)
        XCTAssertEqual(resultImageAttributes[.kern] as? NSNumber, NSNumber(value: 2.0))

        let resultAttachment = try XCTUnwrap(resultImageAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.image, image)
    }

    func testFontWithTraitToImageAndAddBold() throws {
        // Given
        let image = try AImage.pencil()
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
        let result = image.fontWithTrait(trait)

        // Then
        XCTAssertEqual(result, expected)
    }
    #endif
}
