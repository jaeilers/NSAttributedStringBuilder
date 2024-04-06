#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension String: AttributedStringBuilding {

    /// Returns empty attributes.
    /// - Returns: Empty attributes.
    public func attributes() -> Attributes {
        [:]
    }

    /// Returns the text as a mutable attributed string.
    /// - Returns: The string as a mutable attributed string without any attributes.
    public func mutableAttributedString() -> NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }

    /// Creates an attributed string from the current text with the given attributes.
    /// - Parameters:
    ///   - newAttributes: The new attributes will be added to the attributed string.
    /// - Returns: An attributed string with the given attributes.
    public func addingAttributes(_ newAttributes: Attributes) -> NSAttributedString {
        NSAttributedString(string: self, attributes: newAttributes)
    }

    /// Appends an attributed string.
    /// - Parameters:
    ///   - newString: The attributed string will be appended to the current text.
    /// - Returns: The combined attributed string.
    public func addingAttributedString(_ newString: NSAttributedString) -> NSAttributedString {
        NSAttributedString(string: self).addingAttributedString(newString)
    }
}
