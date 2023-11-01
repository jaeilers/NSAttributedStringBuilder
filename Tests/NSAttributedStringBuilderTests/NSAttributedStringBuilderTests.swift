import NSAttributedStringBuilder
import XCTest

final class NSAttributedStringBuilderTests: XCTestCase {

    func testBuilder() throws {
        // Given
        let font = AFont.systemFont(ofSize: 10)
        #if canImport(UIKit)
        let traits: UIFontDescriptor.SymbolicTraits = [.traitBold, .traitItalic, font.fontDescriptor.symbolicTraits]
        #elseif canImport(AppKit)
        let traits: NSFontDescriptor.SymbolicTraits = [.bold, .italic, font.fontDescriptor.symbolicTraits]
        #endif
        let hello = NSAttributedString(
            string: "Hello",
            attributes: [
                .font: font,
                .foregroundColor: AColor.black,
                .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
                .kern: NSNumber(value: 2.0)
            ]
        )

        let space = NSAttributedString(string: " ")

        let worldFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits(traits)),
            size: 0.0
        ))
        let world = NSAttributedString(
            string: "World!",
            attributes: [
                .font: worldFont,
                .foregroundColor: AColor.red
            ]
        )
        let expected = NSMutableAttributedString(attributedString: hello)
        expected.append(space)
        expected.append(world)

        // When
        let result = NSAttributedString {
            "Hello"
                .font(font)
                .foregroundColor(AColor.black)
                .underline()
                .kerning(2.0)

            Space()

            "World!"
                .font(font)
                .bold()
                .italic()
                .foregroundColor(AColor.red)
        }

        // Then
        XCTAssertEqual(result, expected)
    }
}
