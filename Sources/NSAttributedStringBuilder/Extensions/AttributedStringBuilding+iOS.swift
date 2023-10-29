#if canImport(UIKit)
import UIKit

extension AttributedStringBuilding {

    public func bold() -> NSAttributedString {
        addingAttribute(.font, value: fontWithTrait(.traitBold))
    }

    public func italic() -> NSAttributedString {
        addingAttribute(.font, value: fontWithTrait(.traitItalic))
    }
}
#endif

#if canImport(UIKit) && !os(watchOS)
extension AttributedStringBuilding {

    public func image(_ image: UIImage, bounds: CGRect? = nil, accessibilityLabel: String? = nil, accessibilityHint: String? = nil) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image

        accessibilityLabel.map {
            attachment.accessibilityLabel = $0
        }

        accessibilityHint.map {
            attachment.accessibilityHint = $0
        }

        bounds.map {
            attachment.bounds = $0
        }

        return addingAttributedString(NSAttributedString(attachment: attachment))
    }

    public func image(systemName: String, bounds: CGRect? = nil, accessibilityLabel: String? = nil, accessibilityHint: String? = nil) -> NSAttributedString {
        guard let img = UIImage(systemName: systemName) else {
            return mutableAttributedString()
        }

        return image(img, bounds: bounds, accessibilityLabel: accessibilityLabel, accessibilityHint: accessibilityHint)
    }
}
#endif
