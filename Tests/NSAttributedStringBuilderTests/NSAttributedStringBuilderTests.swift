import NSAttributedStringBuilder
import Testing
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

@Suite
struct NSAttributedStringBuilderTests {

    private let string = String.unique()

    @Test
    func builder() throws {
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

        let descriptor = try #require(font.fontDescriptor.withSymbolicTraits(traits))
        let worldFont = try #require(AFont(
            descriptor: descriptor,
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
        #expect(result == expected)
    }

    @Test
    func optionalValueIsPresent() throws {
        // Given
        let text: String? = .unique()
        let expected = NSMutableAttributedString()
        let first = NSAttributedString(
            string: string,
            attributes: [.foregroundColor: AColor.blue]
        )
        let second = NSAttributedString(
            string: try #require(text),
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
        #expect(result == expected)
    }

    @Test
    func optionalValueIsNotPresent() {
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
        #expect(result == expected)
    }

    @Test
    func conditionWithoutElseIsTrue() {
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
        #expect(result == expected)
    }

    @Test
    func conditionalWithElseIsTrue() {
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
        #expect(result == expected)
    }

    @Test
    func conditionalWithElseIsFalse() {
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
        #expect(result == expected)
    }

    @Test
    func limitedAvailability() {
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
        #expect(result == expected)
    }

    @Test
    func buildArray() {
        // Given
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail
        let expected = NSAttributedString(
            string: "abcde",
            attributes: [
                .font: AFont.systemFont(ofSize: 10),
                .foregroundColor: AColor.blue,
                .paragraphStyle: paragraphStyle
            ]
        )

        // When
        let result = NSAttributedString {
            for character in ["a", "b", "c", "d", "e"] {
                character
                    .font(.systemFont(ofSize: 10))
                    .foregroundColor(.blue)
                    .alignment(.center)
                    .lineBreakMode(.byTruncatingTail)
            }
        }

        // Then
        #expect(result == expected)
    }
}
