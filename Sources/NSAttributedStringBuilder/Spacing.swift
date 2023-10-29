/// The type of whitespace.
public enum Spacing: Equatable {
    /// The default whitespace.
    case standard
    /// An En-Space.
    case enSpace
    /// An Em-Space.
    case emSpace

    #if !os(watchOS)
    /// Defines a custom spacing.
    case custom(_ spacing: Double)
    #endif
}
