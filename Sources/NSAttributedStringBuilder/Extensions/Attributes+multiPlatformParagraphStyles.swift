#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension Attributes {

    /// Set the paragraph style..
    ///
    /// Previously set paragraph options are overridden.
    /// - Parameters:
    ///   - paragraphStyle: The paragraph style.
    /// - Returns: The modified attributes.
    func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> Attributes {
        addingAttribute(.paragraphStyle, value: paragraphStyle)
    }

    /// Set the text alignment.
    /// - Parameters:
    ///   - alignment: The text alignment.
    /// - Returns: The modified attributes.
    func alignment(_ alignment: NSTextAlignment) -> Attributes {
        addingParagraphStyle(alignment, keyPath: \.alignment)
    }

    /// Set first line head indent for the text.
    /// - Parameters:
    ///   - indent: The first line head indent.
    /// - Returns: The modified attributes.
    func firstLineHeadIndent(_ indent: CGFloat) -> Attributes {
        addingParagraphStyle(indent, keyPath: \.firstLineHeadIndent)
    }

    /// Set the head indent for the text.
    /// - Parameters:
    ///   - headIndent: The head indent of the attributed string.
    /// - Returns: The modified attributes.
    func headIndent(_ headIndent: CGFloat) -> Attributes {
        addingParagraphStyle(headIndent, keyPath: \.headIndent)
    }

    /// Set the tail indent for the text.
    /// - Parameters:
    ///   - tailIndent: The tail indent of the attributed string.
    /// - Returns: The modified attributes.
    func tailIndent(_ tailIndent: CGFloat) -> Attributes {
        addingParagraphStyle(tailIndent, keyPath: \.tailIndent)
    }

    /// Set the line height multiple for the text.
    /// - Parameters:
    ///   - height: The multiple line height as floating point number.
    /// - Returns: The modified attributes.
    func lineHeightMultiple(_ height: CGFloat) -> Attributes {
        addingParagraphStyle(height, keyPath: \.lineHeightMultiple)
    }

    /// Set the minimum line height for the text.
    /// - Parameters:
    ///   - height: The minimum line height as a floating point number.
    /// - Returns: The modified attributes.
    func minimumLineHeight(_ height: CGFloat) -> Attributes {
        addingParagraphStyle(height, keyPath: \.minimumLineHeight)
    }

    /// Set the maximum line height for the text.
    /// - Parameters:
    ///   - height: The maximum line height as a floating point number.
    /// - Returns: The modified attributes.
    func maximumLineHeight(_ height: CGFloat) -> Attributes {
        addingParagraphStyle(height, keyPath: \.maximumLineHeight)
    }

    /// Set the line spacing for the text.
    /// - Parameters:
    ///   - spacing: The spacing as a floating point number.
    /// - Returns: The modified attributes.
    func lineSpacing(_ spacing: CGFloat) -> Attributes {
        addingParagraphStyle(spacing, keyPath: \.lineSpacing)
    }

    /// Set the paragraph spacing for the text.
    /// - Parameters:
    ///   - spacing: The paragraph spacing as a floating point number.
    /// - Returns: The modified attributes.
    func paragraphSpacing(_ spacing: CGFloat) -> Attributes {
        addingParagraphStyle(spacing, keyPath: \.paragraphSpacing)
    }

    /// Set the paragraph spacing between the current and the previous paragraph.
    /// - Parameters:
    ///   - spacing: The spacing as a floating point number.
    /// - Returns: The modified attributes.
    func paragraphSpacingBefore(_ spacing: CGFloat) -> Attributes {
        addingParagraphStyle(spacing, keyPath: \.paragraphSpacingBefore)
    }

    /// Set the line break mode for the text.
    /// - Parameters:
    ///   - lineBreakMode: The line break mode to use for the text.
    /// - Returns: The modified attributes.
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Attributes {
        addingParagraphStyle(lineBreakMode, keyPath: \.lineBreakMode)
    }

    /// Set the line break strategy for the text.
    /// - Parameters:
    ///   - strategy: The line break strategy of the text.
    /// - Returns: The modified attributes.
    func lineBreakStrategy(_ strategy: NSParagraphStyle.LineBreakStrategy) -> Attributes {
        addingParagraphStyle(strategy, keyPath: \.lineBreakStrategy)
    }

    /// Set the paragraph's threshold for hyphenation.
    /// - Parameters:
    ///   - factor: The hyphenation factor as a floating point number.
    /// - Returns: The modified attributes.
    func hyphenationFactor(_ factor: Float) -> Attributes {
        addingParagraphStyle(factor, keyPath: \.hyphenationFactor)
    }

    /// Set the boolean value whether the paragraph style uses the system hyphenation settings.
    /// - Parameters:
    ///   - usesDefaultHyphenation: A boolean value that indicates whether the system hyphenation settings are used.
    /// - Returns: The modified attributes.
    @available(iOS 15, macOS 13, watchOS 8, tvOS 15, *)
    func usesDefaultHyphenation(_ usesDefaultHyphenation: Bool) -> Attributes {
        addingParagraphStyle(usesDefaultHyphenation, keyPath: \.usesDefaultHyphenation)
    }

    /// Set the boolean value whether the system tightens character spacing before truncating text.
    /// - Parameters:
    ///   - isAllowed: A Boolean value that indicates whether the system tightens character spacing
    ///   before truncating text.
    /// - Returns: The modified attributes.
    func allowsDefaultTighteningForTruncation(_ isAllowed: Bool) -> Attributes {
        addingParagraphStyle(isAllowed, keyPath: \.allowsDefaultTighteningForTruncation)
    }

    /// Set the base writing direction of the text.
    /// - Parameters:
    ///   - direction: The new writing direction of the text.
    /// - Returns: The modified attributes.
    func baseWritingDirection(_ direction: NSWritingDirection) -> Attributes {
        addingParagraphStyle(direction, keyPath: \.baseWritingDirection)
    }

    /// Set the tab stops for the text.
    /// - Parameters:
    ///   - tabStops: The new tab stops.
    ///   - defaultInterval: The default interval of the text tab stops. Default is `0`.
    /// - Returns: The modified attributes.
    func tabStops(_ tabStops: [NSTextTab], defaultInterval: CGFloat = 0) -> Attributes {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.tabStops = tabStops
        paragraphStyle.defaultTabInterval = defaultInterval
        return addingAttribute(.paragraphStyle, value: paragraphStyle)
    }
}

// MARK: - Internal Helper

extension Attributes {

    func addingParagraphStyle<T>(
        _ value: T,
        keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>
    ) -> Attributes {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle[keyPath: keyPath] = value
        return addingAttribute(.paragraphStyle, value: paragraphStyle)
    }
}
