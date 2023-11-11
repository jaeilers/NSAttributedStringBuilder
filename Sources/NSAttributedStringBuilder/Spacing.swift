/// The type of whitespace.
public enum Spacing: Equatable {
    /// The default whitespace.
    case standard
    /// An En-Space.
    case enSpace
    /// An Em-Space.
    case emSpace
    /// A non-breaking space.
    case nonBreakingSpace
    /// A narrow non-breaking space that creates tighter binding between multi-part abbreviations.
    case narrowNonBreakingSpace

    #if !os(watchOS)
    /// Defines a custom spacing.
    case custom(_ spacing: Double)
    #endif
}
