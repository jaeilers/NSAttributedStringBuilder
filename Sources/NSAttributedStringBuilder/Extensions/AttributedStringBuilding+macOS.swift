#if canImport(AppKit)
import AppKit

public extension AttributedStringBuilding {

    /// Returns a copy of the current font with the added trait. (e.g. bold, italic etc.)
    ///
    /// The default font is the standard dynamic type font with style `body`.
    /// - Parameters:
    ///   - trait: The trait that will be added to the current font traits.
    /// - Returns: A copy of the current font where the trait has been added.
    func fontWithTrait(_ trait: NSFontDescriptor.SymbolicTraits) -> NSFont {
        attributes()
            .fontWithTrait(trait)
    }

    /// Adds an image at the end of the attributed string.
    /// - Parameters:
    ///   - image: The image that will be added to the string.
    ///   - bounds: The bounds of the image. The bounds changes the default size and placement of the image.
    ///   If no bounds are provided, then the default asset size is used. Default is `nil`.
    ///   - accessibilityDescription: The accessibility description of the image. Default is `nil`.
    /// - Returns: A copy of the modified attributed string.
    func image(_ image: NSImage, bounds: CGRect? = nil, accessibilityDescription: String? = nil) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image

        bounds.map {
            attachment.bounds = $0
        }

        accessibilityDescription.map {
            image.accessibilityDescription = $0
        }

        return addingAttributedString(NSAttributedString(attachment: attachment))
    }

    /// Adds an image at the end of the attributed string.
    /// - Parameters:
    ///   - systemName: The SF Symbol name (system name) of the image.
    ///   - bounds: The bounds of the image. The bounds changes the default size and placement of the image.
    ///   If no bounds are provided, then the default asset size is used. Default is `nil`.
    ///   - accessibilityDescription: The accessibility description of the image. Default is `nil`.
    /// - Returns: A copy of the modified attributed string.
    func image(
        systemName: String,
        bounds: CGRect? = nil,
        accessibilityDescription: String? = nil
    ) -> NSAttributedString {
        guard let img = NSImage(systemSymbolName: systemName, accessibilityDescription: accessibilityDescription) else {
            return attributedString()
        }

        return image(img, bounds: bounds, accessibilityDescription: accessibilityDescription)
    }

    /// Set a cursor for the attributed string.
    /// - Parameters:
    ///   - cursor: The cursor.
    /// - Returns: A copy of the modified attributed string.
    func cursor(_ cursor: NSCursor) -> NSAttributedString {
        addingAttributes(Attributes().cursor(cursor))
    }

    /// Set the threshold for using tightening as an alternative to truncation.
    /// - Parameters:
    ///   - factor: The threshold as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func tighteningFactorForTruncation(_ factor: Float) -> NSAttributedString {
        addingAttributes(attributes().tighteningFactorForTruncation(factor))
    }

    /// Set the spelling state for the attributed string.
    /// - Parameters:
    ///   - state: The spelling state of the string.
    /// - Returns: A copy of the modified attributed string.
    func spellingState(_ state: NSAttributedStringBuilder.SpellingState) -> NSAttributedString {
        addingAttributes(Attributes().spellingState(state))
    }

    /// Set the superscript of the text.
    /// - Parameters:
    ///   - value: The superscript value as an integer. Default is `1`.
    /// - Returns: A copy of the modified attributed string.
    func superscript(_ value: Int = 1) -> NSAttributedString {
        addingAttributes(Attributes().superscript(value))
    }

    /// Set the text alternatives for the attributed string.
    /// - Parameters:
    ///   - primaryString: The primary string of the text alternatives.
    ///   - alternativeStrings: The alternative strings.
    /// - Returns: A copy of the modified attributed string.
    func textAlternatives(primaryString: String, alternativeStrings: [String]) -> NSAttributedString {
        addingAttributes(
            Attributes()
                .textAlternatives(primaryString: primaryString, alternativeStrings: alternativeStrings)
        )
    }

    /// Set the tool tip for the attributed string.
    /// - Parameters:
    ///   - tip: The text to be displayed as tool tip.
    /// - Returns: A copy of the modified attributed string.
    func toolTip(_ tip: String) -> NSAttributedString {
        addingAttributes(Attributes().toolTip(tip))
    }

    /// The glyph info is assigned by the `NSLayoutManager` object.
    ///
    /// The specified glyph needs to be available in the font specified in `NSAttributedString.Key.font`.
    /// To replace a character use for example the replacement character (� U+FFFD) as a base string for `NSGlyphInfo`.
    /// All occurrences of the replacement character are replaced with the specified glyph.
    /// - Parameters:
    ///   - glyphInfo: The glyph info object to use by the layout manager. You need to specify a `font`
    ///   to use for the `glyphInfo`. If the attributed string does not have a font specified yet,
    ///   a default font will be set: `NSFont.preferredFont(forTextStyle: .body)`.
    /// - Returns: A copy of the modified attributed string.
    func glyphInfo(_ glyphInfo: NSGlyphInfo) -> NSAttributedString {
        addingAttributes(attributes().glyphInfo(glyphInfo))
    }

    /// Set the index of the marked clause segment.
    ///
    /// The value of this attribute contains an integer, as an index in marked text indicating clause segments.
    /// - Parameters:
    ///   - segmentIndex: The index of the marked clause segment.
    /// - Returns: A copy of the modified attributed string.
    func markedClauseSegment(_ segmentIndex: Int) -> NSAttributedString {
        addingAttributes(Attributes().markedClauseSegment(segmentIndex))
    }

    /// Set the paragraph’s header level for HTML generation.
    /// - Parameters:
    ///   - headerLevel: The header level as an integer value. If the paragraph is a header,
    ///   the value ranges from 1 to 6 depending on the header's level.
    /// - Returns: A copy of the modified attributed string.
    func headerLevel(_ headerLevel: Int) -> NSAttributedString {
        addingAttributes(attributes().headerLevel(headerLevel))
    }
}
#endif
