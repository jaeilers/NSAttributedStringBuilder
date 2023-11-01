#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension NSAttributedString: AttributedStringBuilding {

    public func attributes() -> Attributes {
        guard length > 0 else {
            return [:]
        }

        // exclude attachments so that they are not re-added to a different segment
        return attributes(at: length - 1, effectiveRange: nil)
            .filter { $0.key != .attachment }
    }

    public func mutableParagraphStyle() -> NSMutableParagraphStyle {
        guard let paragraphStyle: NSParagraphStyle = attribute(.paragraphStyle) else {
            return NSMutableParagraphStyle()
        }

        return paragraphStyle.mutableCopy() as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
    }

    public func mutableAttributedString() -> NSMutableAttributedString {
        mutableCopy() as? NSMutableAttributedString ?? NSMutableAttributedString()
    }

    public func addingAttributes(_ newAttributes: Attributes) -> NSAttributedString {
        guard length > 0 else {
            return NSAttributedString()
        }
        let result = mutableAttributedString()
        let attributes: Attributes = attributes()
            .merging(newAttributes, uniquingKeysWith: { _, new in new })

        result.addAttributes(attributes, range: NSRange(location: 0, length: result.length))
        return result
    }

    public func addingAttributedString(_ newString: NSAttributedString) -> NSAttributedString {
        let current = mutableAttributedString()
        let newAttributes = attributes()
            .merging(newString.attributes(), uniquingKeysWith: { _, new in new })

        current.append(newString)
        current.addAttributes(newAttributes, range: NSRange(location: 0, length: current.length))

        return current
    }

    #if canImport(UIKit)
    public func fontWithTrait(_ trait: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let font: UIFont = attribute(.font) ?? UIFont.preferredFont(forTextStyle: .body)

        guard let descriptor = font.fontDescriptor.withSymbolicTraits(
            [trait, font.fontDescriptor.symbolicTraits]
        ) else {
            return font
        }

        return UIFont(descriptor: descriptor, size: 0.0)
    }
    #endif

    #if canImport(AppKit)
    public func fontWithTrait(_ trait: NSFontDescriptor.SymbolicTraits) -> NSFont {
        let font: NSFont = attribute(.font) ?? NSFont.preferredFont(forTextStyle: .body)
        let descriptor = font.fontDescriptor.withSymbolicTraits([trait, font.fontDescriptor.symbolicTraits])

        return NSFont(descriptor: descriptor, size: 0.0) ?? font
    }
    #endif
}
