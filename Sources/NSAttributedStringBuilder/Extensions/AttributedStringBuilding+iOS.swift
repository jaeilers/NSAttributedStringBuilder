#if canImport(UIKit)
import UIKit

public extension AttributedStringBuilding {

    func bold() -> NSAttributedString {
        addingAttribute(.font, value: fontWithTrait(.traitBold))
    }

    func italic() -> NSAttributedString {
        addingAttribute(.font, value: fontWithTrait(.traitItalic))
    }
}
#endif

#if canImport(UIKit) && !os(watchOS)
public extension AttributedStringBuilding {

    func image(
        _ image: UIImage,
        bounds: CGRect? = nil,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil
    ) -> NSAttributedString {
        let attachment = NSTextAttachment(image: image)

        bounds.map {
            attachment.bounds = $0
        }

        accessibilityLabel.map {
            attachment.accessibilityLabel = $0
        }

        accessibilityHint.map {
            attachment.accessibilityHint = $0
        }

        return addingAttributedString(NSAttributedString(attachment: attachment))
    }

    func image(
        systemName: String,
        bounds: CGRect? = nil,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil
    ) -> NSAttributedString {
        guard let img = UIImage(systemName: systemName) else {
            return attributedString()
        }

        return image(img, bounds: bounds, accessibilityLabel: accessibilityLabel, accessibilityHint: accessibilityHint)
    }
}
#endif
