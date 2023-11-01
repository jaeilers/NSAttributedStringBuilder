#if canImport(UIKit)
import UIKit
public typealias AFont = UIFont
public typealias AImage = UIImage
public typealias AColor = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias AFont = NSFont
public typealias AImage = NSImage
public typealias AColor = NSColor
#endif

/// Typealias for the attributed string dictionary.
public typealias Attributes = [NSAttributedString.Key: Any]

/// Provides helper methods to mutate an existing (attributed) string.
public protocol AttributedStringBuilding {

    /// Get the attributes of the last character.
    /// - Returns: The current attributes.
    func attributes() -> Attributes

    /// Get the mutable paragraph style of the last character. If none exist, a new paragraph style is created.
    /// - Returns: The current mutable paragraph style.
    func mutableParagraphStyle() -> NSMutableParagraphStyle

    /// Get the current attributed string as mutable attributed string.
    /// - Returns: The current context as mutable attributed string.
    func mutableAttributedString() -> NSMutableAttributedString

    /// Adds new attributes to the current attributed string. The new attributes are applied to the whole range 
    /// and existing attributes are overridden.
    /// - Parameters:
    ///   - newAttributes: The new attributes that will be added to the string.
    /// - Returns: The modified attributed string.
    func addingAttributes(_ newAttributes: Attributes) -> NSAttributedString

    /// Adds an attributed string with its attributes to the current string. The string is appended 
    /// and the attributes of both strings are merged.
    /// The new attributes override existing attributes and new attributes are added.
    /// - Parameters:
    ///   - newString: The new attributed string that is appended to the current context.
    /// - Returns: The modified attributed string.
    func addingAttributedString(_ newString: NSAttributedString) -> NSAttributedString

    #if canImport(UIKit)
    /// Adds a font trait (e.g. bold, italic etc.) to the current attributed string.
    /// - Parameters:
    ///   - trait: The new font trait that will be added to the existing font. 
    ///   Default font is `.preferredFont(forTextStyle: .body)`.
    /// - Returns: A font with the given trait.
    func fontWithTrait(_ trait: UIFontDescriptor.SymbolicTraits) -> UIFont
    #endif

    #if canImport(AppKit)
    /// Adds a font trait (e.g. bold, italic etc.) to the current attributed string.
    /// - Parameters:
    ///   - trait: The new font trait that will be added to the existing font. 
    ///   Default font is `.preferredFont(forTextStyle: .body)`.
    /// - Returns: A font with the given trait.
    func fontWithTrait(_ trait: NSFontDescriptor.SymbolicTraits) -> NSFont
    #endif
}

public extension AttributedStringBuilding {

    /// Get the attribute of the last character.
    /// - Parameters:
    ///   - name: The name of the attribute.
    /// - Returns: The current attribute for a given key.
    func attribute<T>(_ name: NSAttributedString.Key) -> T? {
        let attributes = attributes()
        return attributes[name] as? T
    }

    /// Get the current attributed string.
    ///
    /// This is a convenience method to easily create an attributed string from the current context.
    /// - Returns: The current context as attributed string.
    func attributedString() -> NSAttributedString {
        mutableAttributedString()
    }

    /// Adds an attribute to the current attributed string. An existing attribute is overridden.
    /// - Parameters:
    ///   - name: The name of the attribute.
    ///   - value: The value of the attribute.
    /// - Returns: The modified attributed string.
    func addingAttribute(_ name: NSAttributedString.Key, value: Any) -> NSAttributedString {
        addingAttributes([name: value])
    }

    /// Appends a string to the existing attributed string. Existing attributes are added to the appended string.
    /// - Parameters:
    ///   - newString: The string that will be appended.
    /// - Returns: A modified attributed string.
    func addingString(_ newString: String) -> NSAttributedString {
        addingAttributedString(NSAttributedString(string: newString))
    }
}
