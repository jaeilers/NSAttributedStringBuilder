import NSAttributedStringBuilder
import Testing
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

@Suite
struct NSAttributedStringAppendTests {

    @Test
    func append() {
        // Given
        let lhs = NSAttributedString(
            string: .unique(),
            attributes: [
                .font: AFont.systemFont(ofSize: 10),
                .foregroundColor: AColor.black,
                .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
            ]
        )
        let rhs = NSAttributedString(
            string: .unique(),
            attributes: [
                .font: AFont.systemFont(ofSize: 16),
                .foregroundColor: AColor.red,
                .kern: NSNumber(value: 2.0)
            ]
        )
        let expected = NSMutableAttributedString(attributedString: lhs)
        expected.append(rhs)

        // When
        let result = lhs + rhs

        // Then
        #expect(result == expected)
    }
}
