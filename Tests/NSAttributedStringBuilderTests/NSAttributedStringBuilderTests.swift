import NSAttributedStringBuilder
import XCTest

final class NSAttributedStringBuilderTests: XCTestCase {

    private let string = String.unique()

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

    func testOptionalValueIsPresent() throws {
        // Given
        let text: String? = .unique()
        let expected = NSMutableAttributedString()
        let first = NSAttributedString(
            string: string,
            attributes: [.foregroundColor: AColor.blue]
        )
        let second = NSAttributedString(
            string: try XCTUnwrap(text),
            attributes: [.foregroundColor: AColor.red]
        )
        expected.append(first)
        expected.append(second)

        // When
        let result = NSAttributedString {
            string.foregroundColor(.blue)

            if let text {
                text.foregroundColor(AColor.red)
            }
        }

        // Then
        XCTAssertEqual(result, expected)
    }

    func testOptionalValueIsNotPresent() {
        // Given
        let text: String? = nil
        let expected = NSAttributedString(string: string, attributes: [.foregroundColor: AColor.blue])

        // When
        let result = NSAttributedString {
            string.foregroundColor(.blue)

            if let text {
                text.foregroundColor(.red)
            }
        }

        // Then
        XCTAssertEqual(result, expected)
    }

    func testConditionWithoutElseIsTrue() {
        // Given
        let isUnderlined = true
        let anotherString = String.unique()
        let expected = NSMutableAttributedString()
        let first = NSAttributedString(
            string: string,
            attributes: [
                .font: AFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: AColor.blue
            ])
        let second = NSAttributedString(
            string: anotherString,
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ])
        expected.append(first)
        expected.append(second)

        // When
        let result = NSAttributedString {
            string
                .font(.preferredFont(forTextStyle: .caption1))
                .foregroundColor(.blue)

            if isUnderlined {
                anotherString.underline()
            }
        }

        // Then
        XCTAssertEqual(result, expected)
    }

    func testConditionalWithElseIsTrue() {
        // Given
        let hasLigature = true
        let anotherString = String.unique()
        let expected = NSMutableAttributedString()
        let first = NSAttributedString(
            string: string,
            attributes: [
                .font: AFont.preferredFont(forTextStyle: .subheadline),
                .baselineOffset: NSNumber(value: -1)
            ])
        let second = NSAttributedString(
            string: anotherString,
            attributes: [
                .ligature: NSNumber(value: 1)
            ])
        expected.append(first)
        expected.append(second)

        // When
        let result = NSAttributedString {
            string
                .font(.preferredFont(forTextStyle: .subheadline))
                .baselineOffset(-1)

            if hasLigature {
                anotherString.ligature(.default)
            } else {
                anotherString.ligature(.none)
            }
        }

        // Then
        XCTAssertEqual(result, expected)
    }

    func testConditionalWithElseIsFalse() {
        // Given
        let hasLigature = false
        let anotherString = String.unique()
        let expected = NSMutableAttributedString()
        let first = NSAttributedString(
            string: string,
            attributes: [
                .font: AFont.preferredFont(forTextStyle: .subheadline),
                .baselineOffset: NSNumber(value: -1)
            ])
        let second = NSAttributedString(
            string: anotherString,
            attributes: [
                .ligature: NSNumber(value: 0)
            ])
        expected.append(first)
        expected.append(second)

        // When
        let result = NSAttributedString {
            string
                .font(.preferredFont(forTextStyle: .subheadline))
                .baselineOffset(-1)

            if hasLigature {
                anotherString.ligature(.default)
            } else {
                anotherString.ligature(.none)
            }
        }

        // Then
        XCTAssertEqual(result, expected)
    }

    func testLimitedAvailability() {
        // Given
        let attributes: Attributes

        if #available(iOS 16, macOS 13, tvOS 16, watchOS 9, *) {
            attributes = [
                .languageIdentifier: Locale.LanguageCode.greek.identifier
            ]
        } else {
            attributes = [
                NSAttributedString.Key(kCTLanguageAttributeName as String): NSAttributedStringBuilder.LanguageCode.greek.rawValue
            ]
        }
        let expected = NSAttributedString(string: string,attributes: attributes)

        // When
        let result = NSAttributedString {
            if #available(iOS 16, macOS 13, tvOS 16, watchOS 9, *) {
                string
                    .languageIdentifier(.greek)
            } else {
                string
                    .language(.greek)
            }
        }

        // Then
        XCTAssertEqual(result, expected)
    }
}
