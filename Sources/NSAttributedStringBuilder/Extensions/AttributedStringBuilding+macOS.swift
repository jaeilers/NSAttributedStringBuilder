#if canImport(AppKit)
import AppKit

public extension AttributedStringBuilding {

    func bold() -> NSAttributedString {
        addingAttribute(.font, value: fontWithTrait(.bold))
    }

    func italic() -> NSAttributedString {
        addingAttribute(.font, value: fontWithTrait(.italic))
    }

    func image(_ image: NSImage, size: CGSize? = nil, accessibilityDescription: String? = nil) -> NSAttributedString {
        size.map {
            image.size = $0
        }

        accessibilityDescription.map {
            image.accessibilityDescription = $0
        }

        let attachment = NSTextAttachment()
        attachment.image = image

        return addingAttributedString(NSAttributedString(attachment: attachment))
    }

    func image(systemName: String, size: CGSize? = nil, accessibilityDescription: String? = nil) -> NSAttributedString {
        guard let img = NSImage(systemSymbolName: systemName, accessibilityDescription: accessibilityDescription) else {
            return mutableAttributedString()
        }

        return image(img, size: size, accessibilityDescription: accessibilityDescription)
    }

    func cursor(_ cursor: NSCursor) -> NSAttributedString {
        addingAttribute(.cursor, value: cursor)
    }

    func tighteningFactorForTruncation(_ factor: Float) -> NSAttributedString {
        addingParagraphStyle(factor, keyPath: \.tighteningFactorForTruncation)
    }

    func spellingState(_ state: NSAttributedStringBuilder.SpellingState) -> NSAttributedString {
        addingAttribute(.spellingState, value: state.rawValue)
    }

    func superscript(_ value: Int = 1) -> NSAttributedString {
        addingAttribute(.superscript, value: NSNumber(value: value))
    }

    func textAlternatives(primaryString: String, alternativeStrings: [String]) -> NSAttributedString {
        let textAlternatives = NSTextAlternatives(primaryString: primaryString, alternativeStrings: alternativeStrings)
        return addingAttribute(.textAlternatives, value: textAlternatives)
    }

    func toolTip(_ tip: String) -> NSAttributedString {
        addingAttribute(.toolTip, value: tip as NSString)
    }

    func headerLevel(_ headerLevel: Int) -> NSAttributedString {
        addingParagraphStyle(headerLevel, keyPath: \.headerLevel)
    }
}
#endif
