#if canImport(UIKit)
import UIKit

public extension AttributedStringBuilding {

    /// Adds the bold trait to the current font.
    /// - Returns: A copy of the modified attributed string.
    func bold() -> NSAttributedString {
        addingAttribute(.font, value: fontWithTrait(.traitBold))
    }

    /// Adds the italic trait to the current font.
    /// - Returns: A copy of the modified attributed string.
    func italic() -> NSAttributedString {
        addingAttribute(.font, value: fontWithTrait(.traitItalic))
    }

    /// Modifies the font of the text to used fixed-width variant of the current font, if possible.
    /// - Returns: A copy of the modified attributed string.
    func monospaced() -> NSAttributedString {
        addingAttribute(.font, value: fontWithTrait(.traitMonoSpace))
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
