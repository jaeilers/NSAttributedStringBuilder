import Foundation
import NSAttributedStringBuilder
import Testing

@Suite
struct NSAttributedStringConvenienceMethodsTests {

    @Test
    func space() {
        #expect(Space() == NSAttributedString(string: " "))
    }

    @Test
    func spaceWithStandard() {
        #expect(Space(.standard) == NSAttributedString(string: " "))
    }

    @Test
    func spaceWithOptionEnSpace() {
        #expect(Space(.enSpace) == NSAttributedString(string: "\u{2002}"))
    }

    @Test
    func spaceWithOptionEmSpace() {
        #expect(Space(.emSpace) == NSAttributedString(string: "\u{2003}"))
    }

    @Test
    func spaceWithOptionNonBreaking() {
        #expect(Space(.nonBreakingSpace) == NSAttributedString(string: "\u{00A0}"))
    }

    @Test
    func spaceWithOptionNarrowNonBreaking() {
        #expect(Space(.narrowNonBreakingSpace) == NSAttributedString(string: "\u{202F}"))
    }

    @Test
    func nonBreakingSpace() {
        #expect(NonBreakingSpace() == NSAttributedString(string: "\u{00A0}"))
    }

    @Test
    func newline() {
        #expect(Newline() == NSAttributedString(string: "\n"))
    }
}
