#if canImport(AppKit)
public extension NSAttributedStringBuilder {

    /// Defines a spelling state for the attributed string. (macOS only)
    enum SpellingState: Int, Hashable, Codable, Sendable {
        /// Indicates that the attributed string has no spelling errors.
        case noGrammarOrSpellingIssues
        /// Flag for spelling issues.
        case spellingErrors
        /// Flag for grammar issues.
        case grammarErrors
    }
}
#endif
