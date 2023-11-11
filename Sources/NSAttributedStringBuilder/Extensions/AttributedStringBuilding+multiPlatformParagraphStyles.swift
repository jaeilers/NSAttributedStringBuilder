#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// Multiplatform extension to support paragraph styles.
public extension AttributedStringBuilding {

    /// Set the paragraph style of the attributed string.
    ///
    /// Previously set paragraph options are overriden.
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
        addingParagraphStyle(alignment, keyPath: \.alignment)
    }

    /// Set first line head indent for the text.
    /// - Parameters:
    ///   - indent: The first line head indent.
    /// - Returns: A copy of the modified attributed string.
    func firstLineHeadIndent(_ indent: CGFloat) -> NSAttributedString {
        addingParagraphStyle(indent, keyPath: \.firstLineHeadIndent)
    }

    /// Set the head indent for the text.
    /// - Parameters:
    ///   - headIndent: The head indent of the attributed string.
    /// - Returns: A copy of the modified attributed string.
    func headIndent(_ headIndent: CGFloat) -> NSAttributedString {
        addingParagraphStyle(headIndent, keyPath: \.headIndent)
    }

    /// Set the tail indent for the text.
    /// - Parameters:
    ///   - tailIndent: The tail indent of the attributed string.
    /// - Returns: A copy of the modified attributed string.
    func tailIndent(_ tailIndent: CGFloat) -> NSAttributedString {
        addingParagraphStyle(tailIndent, keyPath: \.tailIndent)
    }

    /// Set the line height multiple for the text.
    /// - Parameters:
    ///   - height: The multiple line height as floating point number.
    /// - Returns: A copy of the modified attributed string.
    func lineHeightMultiple(_ height: CGFloat) -> NSAttributedString {
        addingParagraphStyle(height, keyPath: \.lineHeightMultiple)
    }

    /// Set the minimum line height for the text.
    /// - Parameters:
    ///   - height: The minium line height as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func minimumLineHeight(_ height: CGFloat) -> NSAttributedString {
        addingParagraphStyle(height, keyPath: \.minimumLineHeight)
    }

    /// Set the maximum line height for the text.
    /// - Parameters:
    ///   - height: The maximum line height as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func maximumLineHeight(_ height: CGFloat) -> NSAttributedString {
        addingParagraphStyle(height, keyPath: \.maximumLineHeight)
    }

    /// Set the line spacing for the text.
    /// - Parameters:
    ///   - spacing: The spacing as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func lineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        addingParagraphStyle(spacing, keyPath: \.lineSpacing)
    }

    /// Set the paragraph spacing for the text.
    /// - Parameters:
    ///   - spacing: The paragraph spacing as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func paragraphSpacing(_ spacing: CGFloat) -> NSAttributedString {
        addingParagraphStyle(spacing, keyPath: \.paragraphSpacing)
    }

    /// Set the paragraph spacing between the current and the previous paragraph.
    /// - Parameters:
    ///   - spacing: The spacing as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func paragraphSpacingBefore(_ spacing: CGFloat) -> NSAttributedString {
        addingParagraphStyle(spacing, keyPath: \.paragraphSpacingBefore)
    }

    /// Set the line break mode for the text.
    /// - Parameters:
    ///   - lineBreakMode: The line break mode to use for the text.
    /// - Returns: A copy of the modified attributed string.
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> NSAttributedString {
        addingParagraphStyle(lineBreakMode, keyPath: \.lineBreakMode)
    }

    /// Set the line break strategy for the text.
    /// - Parameters:
    ///   - strategy: The line break strategy of the text.
    /// - Returns: A copy of the modified attributed string.
    func lineBreakStrategy(_ strategy: NSParagraphStyle.LineBreakStrategy) -> NSAttributedString {
        addingParagraphStyle(strategy, keyPath: \.lineBreakStrategy)
    }

    /// Set the paragraph's threshold for hyphenation.
    /// - Parameters:
    ///   - factor: The hyphenation factor as a floating point number.
    /// - Returns: A copy of the modified attributed string.
    func hyphenationFactor(_ factor: Float) -> NSAttributedString {
        addingParagraphStyle(factor, keyPath: \.hyphenationFactor)
    }

    /// Set the boolean value whether the paragraph style uses the system hyphenation settings.
    /// - Parameters:
    ///   - usesDefaultHyphenation: A boolean value that indicates whether the system hyphenation settings are used.
    /// - Returns: A copy of the modified attributed string.
    @available(iOS 15, macOS 13, watchOS 8, tvOS 15, *)
    func usesDefaultHyphenation(_ usesDefaultHyphenation: Bool) -> NSAttributedString {
        addingParagraphStyle(usesDefaultHyphenation, keyPath: \.usesDefaultHyphenation)
    }

    /// Set the boolean value whether the system tightens character spacing before truncating text.
    /// - Parameters:
    ///   - isAllowed: A Boolean value that indicates whether the system tightens character spacing
    ///   before truncating text.
    /// - Returns: A copy of the modified attributed string.
    func allowsDefaultTighteningForTruncation(_ isAllowed: Bool) -> NSAttributedString {
        addingParagraphStyle(isAllowed, keyPath: \.allowsDefaultTighteningForTruncation)
    }

    /// Set the base writing direction of the text.
    /// - Parameters:
    ///   - direction: The new writing direction of the text.
    /// - Returns: A copy of the modified attributed string.
    func baseWritingDirection(_ direction: NSWritingDirection) -> NSAttributedString {
        addingParagraphStyle(direction, keyPath: \.baseWritingDirection)
    }

    /// Set the tab stops for the attributed string.
    /// - Parameters:
    ///   - tabStops: The new tab stops.
    ///   - defaultInterval: The default interval of the text tab stops. Default is `0`.
    /// - Returns: A copy of the modified attributed string.
    func tabStops(_ tabStops: [NSTextTab], defaultInterval: CGFloat = 0) -> NSAttributedString {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.tabStops = tabStops
        paragraphStyle.defaultTabInterval = defaultInterval
        return addingAttribute(.paragraphStyle, value: paragraphStyle)
    }
}

// MARK: - Internal Helpers

extension AttributedStringBuilding {

    /// Add or override an existing paragraph style attribute.
    /// - Parameters:
    ///   - value: The new value for the attribute.
    ///   - keyPath: The keypath of the attribute in paragraph style.
    /// - Returns: A copy of the modified attributed string.
    func addingParagraphStyle<Value>(
        _ value: Value,
        keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, Value>
    ) -> NSAttributedString {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle[keyPath: keyPath] = value
        return addingAttribute(.paragraphStyle, value: paragraphStyle)
    }
}
