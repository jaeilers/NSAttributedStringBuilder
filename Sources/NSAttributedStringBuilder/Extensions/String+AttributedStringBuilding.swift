#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension String: AttributedStringBuilding {

    public func attributes() -> Attributes {
        [:]
    }

    public func mutableParagraphStyle() -> NSMutableParagraphStyle {
        NSMutableParagraphStyle()
    }

    public func mutableAttributedString() -> NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }

    public func addingAttributes(_ newAttributes: Attributes) -> NSAttributedString {
        NSAttributedString(string: self, attributes: newAttributes)
    }

    public func addingAttributedString(_ newString: NSAttributedString) -> NSAttributedString {
        NSAttributedString(string: self).addingAttributedString(newString)
    }

    #if canImport(UIKit)
    public func fontWithTrait(_ trait: UIFontDescriptor.SymbolicTraits) -> UIFont {
        NSAttributedString(string: self).fontWithTrait(trait)
    }
    #endif

    #if canImport(AppKit)
    public func fontWithTrait(_ trait: NSFontDescriptor.SymbolicTraits) -> NSFont {
        NSAttributedString(string: self).fontWithTrait(trait)
    }
    #endif
}
