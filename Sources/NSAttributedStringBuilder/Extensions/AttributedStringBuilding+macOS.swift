#if canImport(AppKit)
import AppKit

extension AttributedStringBuilding {

    public func bold() -> NSAttributedString {
        addingAttribute(.font, value: fontWithTrait(.bold))
    }

    public func italic() -> NSAttributedString {
        addingAttribute(.font, value: fontWithTrait(.italic))
    }

    public func image(_ image: NSImage, size: CGSize? = nil, accessibilityDescription: String? = nil) -> NSAttributedString {
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

    public func image(systemName: String, size: CGSize? = nil, accessibilityDescription: String? = nil) -> NSAttributedString {
        guard let img = NSImage(systemSymbolName: systemName, accessibilityDescription: accessibilityDescription) else {
            return mutableAttributedString()
        }

        return image(img, size: size, accessibilityDescription: accessibilityDescription)
    }

    public func cursor(_ cursor: NSCursor) -> NSAttributedString {
        addingAttribute(.cursor, value: cursor)
    }

    public func tighteningFactorForTruncation(_ factor: Float) -> NSAttributedString {
        addingParagraphStyle(factor, keyPath: \.tighteningFactorForTruncation)
    }

    public func spellingState(_ state: NSAttributedStringBuilder.SpellingState) -> NSAttributedString {
        addingAttribute(.spellingState, value: state.rawValue)
    }

    public func superscript(_ value: Int = 1) -> NSAttributedString {
        addingAttribute(.superscript, value: NSNumber(value: value))
    }

    public func textAlternatives(primaryString: String, alternativeStrings: [String]) -> NSAttributedString {
        let textAlternatives = NSTextAlternatives(primaryString: primaryString, alternativeStrings: alternativeStrings)
        return addingAttribute(.textAlternatives, value: textAlternatives)
    }

    public func toolTip(_ tip: String) -> NSAttributedString {
        addingAttribute(.toolTip, value: tip as NSString)
    }

    public func headerLevel(_ headerLevel: Int) -> NSAttributedString {
        addingParagraphStyle(headerLevel, keyPath: \.headerLevel)
    }
}
#endif
