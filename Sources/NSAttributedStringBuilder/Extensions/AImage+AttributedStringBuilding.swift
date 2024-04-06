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
}
#endif
