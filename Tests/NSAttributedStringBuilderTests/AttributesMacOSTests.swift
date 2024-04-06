#if canImport(AppKit)
@testable import NSAttributedStringBuilder
import XCTest

final class AttributesMacOSTests: XCTestCase {

    func testBoldWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.bold, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().bold()

        // Then
        XCTAssertTrue(NSDictionary(dictionary: result).isEqual(to: expected))
    }

    func testBoldWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.bold, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.bold()

        // Then
        XCTAssertTrue(NSDictionary(dictionary: result).isEqual(to: expected))
    }

    func testItalicWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.italic, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().italic()

        // Then
        XCTAssertTrue(NSDictionary(dictionary: result).isEqual(to: expected))
    }

    func testItalicWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.italic, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.italic()

        // Then
        XCTAssertTrue(NSDictionary(dictionary: result).isEqual(to: expected))
    }

    func testMonospacedWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.monoSpace, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().monospaced()

        // Then
        XCTAssertTrue(NSDictionary(dictionary: result).isEqual(to: expected))
    }

    func testMonospacedWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.monoSpace, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.monospaced()

        // Then
        XCTAssertTrue(NSDictionary(dictionary: result).isEqual(to: expected))
    }

    func testCondensedWithNoFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .body)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.condensed, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = Attributes().condensed()

        // Then
        XCTAssertTrue(NSDictionary(dictionary: result).isEqual(to: expected))
    }

    func testCondensedWithExistingFont() throws {
        // Given
        let font = AFont.preferredFont(forTextStyle: .headline)
        let expectedFont = try XCTUnwrap(AFont(
            descriptor: XCTUnwrap(font.fontDescriptor.withSymbolicTraits([.condensed, font.fontDescriptor.symbolicTraits])),
            size: 0.0
        ))
        let attributes: Attributes = [
            .font: font
        ]
        let expected: Attributes = [
            .font: expectedFont
        ]

        // When
        let result = attributes.condensed()

        // Then
        XCTAssertTrue(NSDictionary(dictionary: result).isEqual(to: expected))
    }
}
#endif
