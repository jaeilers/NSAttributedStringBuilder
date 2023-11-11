import NSAttributedStringBuilder
import XCTest

final class NSAttributedStringConvenienceMethodsTests: XCTestCase {

    func testSpace() {
        XCTAssertEqual(Space(), NSAttributedString(string: " "))
    }

    func testSpaceWithStandard() {
        XCTAssertEqual(Space(.standard), NSAttributedString(string: " "))
    }

    func testSpaceWithOptionEnSpace() {
        XCTAssertEqual(Space(.enSpace), NSAttributedString(string: "\u{2002}"))
    }

    func testSpaceWithOptionEmSpace() {
        XCTAssertEqual(Space(.emSpace), NSAttributedString(string: "\u{2003}"))
    }

    func testSpaceWithOptionNonBreaking() {
        XCTAssertEqual(Space(.nonBreakingSpace), NSAttributedString(string: "\u{00A0}"))
    }

    func testSpaceWithOptionNarrowNonBreaking() {
        XCTAssertEqual(Space(.narrowNonBreakingSpace), NSAttributedString(string: "\u{202F}"))
    }

    func testNonBreakingSpace() {
        XCTAssertEqual(NonBreakingSpace(), NSAttributedString(string: "\u{00A0}"))
    }

    func testNewline() {
        XCTAssertEqual(Newline(), NSAttributedString(string: "\n"))
    }
}
