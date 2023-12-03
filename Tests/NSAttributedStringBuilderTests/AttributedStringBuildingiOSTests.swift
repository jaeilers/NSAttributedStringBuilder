#if canImport(UIKit) && !os(watchOS)
import NSAttributedStringBuilder
import XCTest

final class AttributedStringBuildingiOSTests: XCTestCase {

    private let string = String.unique()

    func testUIImageWithAttributedString() throws {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.blue,
            .kern: NSNumber(value: 1.0)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let bounds = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        let image = try UIImage.pencil()

        // When
        let result = attributedString.image(image, bounds: bounds)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertEqual(resultAttachment.image, image)
        XCTAssertEqual(resultAttributes[.font] as? UIFont, UIFont.preferredFont(forTextStyle: .body))
        XCTAssertEqual(resultAttributes[.foregroundColor] as? UIColor, UIColor.blue)
        XCTAssertEqual(resultAttributes[.kern] as? NSNumber, NSNumber(value: 1.0))

        let resultAttributedString = result.attributedSubstring(from: NSRange(location: 0, length: attributedString.length))
        XCTAssertEqual(resultAttributedString, attributedString)
    }

    func testUIImageWithAttributedStringAndSystemName() throws {
        // Given
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.orange,
            .kern: NSNumber(value: 1.0)
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        let bounds = CGRect(origin: .zero, size: .init(width: 1, height: 1))

        // When
        let result = attributedString.image(systemName: "pencil", bounds: bounds)

        // Then
        let resultAttributes = result.attributes(at: result.length - 1, effectiveRange: nil)
        let resultAttachment = try XCTUnwrap(resultAttributes[.attachment] as? NSTextAttachment)
        XCTAssertNotNil(resultAttachment.image)
        XCTAssertEqual(resultAttributes[.font] as? UIFont, UIFont.preferredFont(forTextStyle: .body))
        XCTAssertEqual(resultAttributes[.foregroundColor] as? UIColor, UIColor.orange)
        XCTAssertEqual(resultAttributes[.kern] as? NSNumber, NSNumber(value: 1.0))

        let resultAttributedString = result.attributedSubstring(from: NSRange(location: 0, length: attributedString.length))
        XCTAssertEqual(resultAttributedString, attributedString)
    }
}
#endif
