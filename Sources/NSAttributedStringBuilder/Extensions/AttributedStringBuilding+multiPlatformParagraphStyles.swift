#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// Multiplatform extension to support paragraph styles.
public extension AttributedStringBuilding {

    /// Set the paragraph style of the attributed string.
    ///
    /// Previously set paragraph options are overridden.
    /// - Parameters:
    ///   - paragraphStyle: The paragraph style.
    /// - Returns: A copy of the modified attributed string.
    func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        addingAttribute(.paragraphStyle, value: paragraphStyle)
    }

    /// Set the text alignment for the attributed string.
    /// - Parameters:
    ///   - alignment: The text alignment.
    /// - Returns: A copy of the modified attributed string.
    func alignment(_ alignment: NSTextAlignment) -> NSAttributedString {
        addingAttributes(attributes().alignment(alignment))
    }

    /// Set first line head indent for the text.
    /// - Parameters:
    ///   - indent: The first line head indent.
    /// - Returns: A copy of the modified attributed string.
    func firstLineHeadIndent(_ indent: CGFloat) -> NSAttributedString {
        addingAttributes(attributes().firstLineHeadIndent(indent))
    }

    /// Set the head indent for the text.
    /// - Parameters:
    ///   - headIndent: The head indent of the attributed string.
    /// - Returns: A copy of the modified attributed string.
    func headIndent(_ headIndent: CGFloat) -> NSAttributedString {
        addingAttributes(attributes().headIndent(headIndent))
    }

    /// Set the tail indent for the text.
    /// - Parameters:
    ///   - tailIndent: The tail indent of the attributed string.
    /// - Returns: A copy of the modified attributed string.
    func tailIndent(_ tailIndent: CGFloat) -> NSAttributedString {
        addingAttributes(attributes().tailIndent(tailIndent))
    }

    /// Set the line height multiple for the text.
    /// - Parameters:
    ///   - height: The multiple line height as floating point number.
    /// - Returns: A copy of the modified attributed string.
    func lineHeightMultiple(_ height: CGFloat) -> NSAttributedString {
        addingAttributes(attributes().lineHeightMultiple(height))
    }

    /// Set the minimum line height for the text.
    /// - Parameters:
    ///   - height: The minimum line height as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func minimumLineHeight(_ height: CGFloat) -> NSAttributedString {
        addingAttributes(attributes().minimumLineHeight(height))
    }

    /// Set the maximum line height for the text.
    /// - Parameters:
    ///   - height: The maximum line height as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func maximumLineHeight(_ height: CGFloat) -> NSAttributedString {
        addingAttributes(attributes().maximumLineHeight(height))
    }

    /// Set the line spacing for the text.
    /// - Parameters:
    ///   - spacing: The spacing as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func lineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        addingAttributes(attributes().lineSpacing(spacing))
    }

    /// Set the paragraph spacing for the text.
    /// - Parameters:
    ///   - spacing: The paragraph spacing as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func paragraphSpacing(_ spacing: CGFloat) -> NSAttributedString {
        addingAttributes(attributes().paragraphSpacing(spacing))
    }

    /// Set the paragraph spacing between the current and the previous paragraph.
    /// - Parameters:
    ///   - spacing: The spacing as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func paragraphSpacingBefore(_ spacing: CGFloat) -> NSAttributedString {
        addingAttributes(attributes().paragraphSpacingBefore(spacing))
    }

    /// Set the line break mode for the text.
    /// - Parameters:
    ///   - lineBreakMode: The line break mode to use for the text.
    /// - Returns: A copy of the modified attributed string.
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> NSAttributedString {
        addingAttributes(attributes().lineBreakMode(lineBreakMode))
    }

    /// Set the line break strategy for the text.
    /// - Parameters:
    ///   - strategy: The line break strategy of the text.
    /// - Returns: A copy of the modified attributed string.
    func lineBreakStrategy(_ strategy: NSParagraphStyle.LineBreakStrategy) -> NSAttributedString {
        addingAttributes(attributes().lineBreakStrategy(strategy))
    }

    /// Set the paragraph's threshold for hyphenation.
    /// - Parameters:
    ///   - factor: The hyphenation factor as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func hyphenationFactor(_ factor: Float) -> NSAttributedString {
        addingAttributes(attributes().hyphenationFactor(factor))
    }

    /// Set the boolean value whether the paragraph style uses the system hyphenation settings.
    /// - Parameters:
    ///   - usesDefaultHyphenation: A boolean value that indicates whether the system hyphenation settings are used.
    /// - Returns: A copy of the modified attributed string.
    @available(iOS 15, macOS 13, watchOS 8, tvOS 15, *)
    func usesDefaultHyphenation(_ usesDefaultHyphenation: Bool) -> NSAttributedString {
        addingAttributes(attributes().usesDefaultHyphenation(usesDefaultHyphenation))
    }

    /// Set the boolean value whether the system tightens character spacing before truncating text.
    /// - Parameters:
    ///   - isAllowed: A Boolean value that indicates whether the system tightens character spacing
    ///   before truncating text.
    /// - Returns: A copy of the modified attributed string.
    func allowsDefaultTighteningForTruncation(_ isAllowed: Bool) -> NSAttributedString {
        addingAttributes(attributes().allowsDefaultTighteningForTruncation(isAllowed))
    }

    /// Set the base writing direction of the text.
    /// - Parameters:
    ///   - direction: The new writing direction of the text.
    /// - Returns: A copy of the modified attributed string.
    func baseWritingDirection(_ direction: NSWritingDirection) -> NSAttributedString {
        addingAttributes(attributes().baseWritingDirection(direction))
    }

    /// Set the tab stops for the attributed string.
    /// - Parameters:
    ///   - tabStops: The new tab stops.
    ///   - defaultInterval: The default interval of the text tab stops. Default is `0`.
    /// - Returns: A copy of the modified attributed string.
    func tabStops(_ tabStops: [NSTextTab], defaultInterval: CGFloat = 0) -> NSAttributedString {
        addingAttributes(attributes().tabStops(tabStops, defaultInterval: defaultInterval))
    }
}
