import NSAttributedStringBuilder
import XCTest

final class NSAttributedStringConvenienceMethodsTests: XCTestCase {

    func testSpace() {
        XCTAssertEqual(Space(), NSAttributedString(string: " "))
    }

    func testNonBreakingSpace() {
        XCTAssertEqual(NonBreakingSpace(), NSAttributedString(string: "\u{00A0}"))
    }

    func testNewline() {
        XCTAssertEqual(Newline(), NSAttributedString(string: "\n"))
    }
}
