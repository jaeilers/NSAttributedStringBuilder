#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

#if !os(watchOS)
extension AImage: AttributedStringBuilding {

    public func attributes() -> Attributes {
        [:]
    }

    public func mutableParagraphStyle() -> NSMutableParagraphStyle {
        NSMutableParagraphStyle()
    }

    public func mutableAttributedString() -> NSMutableAttributedString {
        NSMutableAttributedString(attributedString: .init().image(self))
    }

    public func addingAttributes(_ newAttributes: Attributes) -> NSAttributedString {
        NSAttributedString()
            .image(self)
            .addingAttributes(newAttributes)
    }

    public func addingAttributedString(_ newString: NSAttributedString) -> NSAttributedString {
        NSAttributedString()
            .image(self)
            .addingAttributedString(newString)
    }

    #if canImport(UIKit)
    public func fontWithTrait(_ trait: UIFontDescriptor.SymbolicTraits) -> UIFont {
        NSAttributedString()
            .image(self)
            .fontWithTrait(trait)
    }
    #endif

    #if canImport(AppKit)
    public func fontWithTrait(_ trait: NSFontDescriptor.SymbolicTraits) -> NSFont {
        NSAttributedString()
            .image(self)
            .fontWithTrait(trait)
    }
    #endif
}
#endif
