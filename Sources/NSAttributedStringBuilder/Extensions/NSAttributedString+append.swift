import Foundation

public extension NSAttributedString {

    /// Concats two attributed strings.
    /// - Parameters:
    ///   - lhs: The left-hand side attributed string.
    ///   - rhs: The right-hand side attributed string.
    /// - Returns: The combined attributed string.
    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: lhs)
        result.append(rhs)
        return result
    }
}
