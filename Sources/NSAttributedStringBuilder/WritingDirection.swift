import Foundation

extension NSAttributedStringBuilder {

    /// Combines `NSWritingDirection` and `NSWritingDirectionFormatType`.
    public enum WritingDirection: NSNumber {
        case leftToRightDirectionEmbedding
        case rightToLeftDirectionEmbedding
        case leftToRightDirectionOverride
        case rightToLeftDirectionOverride
    }
}
