#if canImport(UIKit)
import UIKit

/// A typealias for UIFont.
public typealias AFont = UIFont
/// A typealias for UIImage.
public typealias AImage = UIImage
/// A typealias for UIColor.
public typealias AColor = UIColor
#elseif canImport(AppKit)
import AppKit

/// A typealias for NSFont.
public typealias AFont = NSFont
/// A typealias for NSImage.
public typealias AImage = NSImage
/// A typealias for NSColor.
public typealias AColor = NSColor
#endif

/// Typealias for the attributed string dictionary.
public typealias Attributes = [NSAttributedString.Key: Any]

/// Provides methods to build an attributed string.
public protocol AttributedStringBuilding {

    /// Get the attributes of the last character.
    /// - Returns: The current attributes.
    func attributes() -> Attributes

    /// Get the current attributed string as mutable attributed string.
    /// - Returns: A copy of the current context as a mutable attributed string.
    func mutableAttributedString() -> NSMutableAttributedString

    /// Adds new attributes to the current attributed string.
    ///
    /// The new attributes are applied to the whole range and existing attributes are overridden.
    /// - Parameters:
    ///   - newAttributes: The new attributes that will be added to the string.
    /// - Returns: A copy of the modified attributed string.
    func addingAttributes(_ newAttributes: Attributes) -> NSAttributedString

    /// Adds an attributed string with its attributes to the current string.
    ///
    /// The string is appended and the attributes of both strings are merged.
    /// The new attributes override existing attributes and new attributes are added.
    /// - Parameters:
    ///   - newString: The new attributed string that is appended to the current context.
    /// - Returns: A copy of the modified attributed string.
    func addingAttributedString(_ newString: NSAttributedString) -> NSAttributedString
}
