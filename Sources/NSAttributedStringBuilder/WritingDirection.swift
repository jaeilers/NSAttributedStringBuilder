import Foundation

public extension NSAttributedStringBuilder {

    /// Combines `NSWritingDirection` and `NSWritingDirectionFormatType`.
    enum WritingDirection: NSNumber {
        case leftToRightDirectionEmbedding
        case rightToLeftDirectionEmbedding
        case leftToRightDirectionOverride
        case rightToLeftDirectionOverride
    }
}
