import Foundation

public extension NSAttributedStringBuilder {

    /// Combines `NSWritingDirection` and `NSWritingDirectionFormatType`
    /// into one type that can be used with `writingDirection(_:)`.
    enum WritingDirection: NSNumber {
        case leftToRightDirectionEmbedding
        case rightToLeftDirectionEmbedding
        case leftToRightDirectionOverride
        case rightToLeftDirectionOverride
    }
}
