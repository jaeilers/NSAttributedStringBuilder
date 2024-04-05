#if canImport(UIKit)
import UIKit

public extension Attributes {

    /// Returns a copy of the current font with the added trait. (e.g. bold, italic etc.)
    ///
    /// The default font is the standard dynamic type font with style `body`.
    /// - Parameters:
    ///   - trait: The trait that will be added to the current font traits.
    /// - Returns: A copy of the current font where the trait has been added.
    func fontWithTrait(_ trait: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let font: UIFont = attribute(.font) ?? UIFont.preferredFont(forTextStyle: .body)

        guard let descriptor = font.fontDescriptor.withSymbolicTraits(
            [trait, font.fontDescriptor.symbolicTraits]
        ) else {
            return font
        }

        return UIFont(descriptor: descriptor, size: 0.0)
    }

    /// Adds the bold trait to the current font.
    /// - Returns: The modified attributes.
    func bold() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.traitBold))
    }

    /// Adds the italic trait to the current font.
    /// - Returns: The modified attributes.
    func italic() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.traitItalic))
    }

    /// Modifies the font of the text to use a fixed-width variant of the current font, if possible.
    /// - Returns: The modified attributes.
    func monospaced() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.traitMonoSpace))
    }

    /// Adds the condensed trait to the current font.
    /// - Returns: The modified attributes.
    func condensed() -> Attributes {
        addingAttribute(.font, value: fontWithTrait(.traitCondensed))
    }
}
#endif
