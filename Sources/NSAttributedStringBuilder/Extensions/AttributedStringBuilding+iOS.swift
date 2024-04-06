#if canImport(UIKit)
import UIKit

public extension AttributedStringBuilding {

    /// Returns a copy of the current font with the added trait. (e.g. bold, italic etc.)
    ///
    /// The default font is the standard dynamic type font with style `body`.
    /// - Parameters:
    ///   - trait: The trait that will be added to the current font traits.
    /// - Returns: A copy of the current font where the trait has been added.
    func fontWithTrait(_ trait: UIFontDescriptor.SymbolicTraits) -> UIFont {
        attributes()
            .fontWithTrait(trait)
    }
}
#endif

#if canImport(UIKit) && !os(watchOS)
public extension AttributedStringBuilding {

    /// Adds an image at the end of the attributed string.
    ///
    /// Existing attributes are added to the image.
    /// - Parameters:
    ///   - image: The image that will be added to the string.
    ///   - bounds: The bounds of the image. The bounds changes the default size
    ///   If no bounds are provided, then the default asset size is used. Default is `nil`.
    /// - Returns: A copy of the modified attributed string.
    func image(
        _ image: UIImage,
        bounds: CGRect? = nil
    ) -> NSAttributedString {
        let attachment = NSTextAttachment(image: image)
        bounds.map {
            attachment.bounds = $0
        }

        return addingAttributedString(NSAttributedString(attachment: attachment))
    }

    /// Adds an image at the end of the attributed string.
    ///
    /// Existing attributes are added to the image.
    /// - Parameters:
    ///   - systemName: The SF Symbol name (system name) of the image.
    ///   - bounds: The bounds of the image. The bounds changes the default size and placement of the image.
    ///   If no bounds are provided, then the default asset size is used. Default is `nil`.
    /// - Returns: A copy of the modified attributed string.
    func image(
        systemName: String,
        bounds: CGRect? = nil
    ) -> NSAttributedString {
        guard let img = UIImage(systemName: systemName) else {
            return attributedString()
        }

        return image(img, bounds: bounds)
    }
}
#endif
