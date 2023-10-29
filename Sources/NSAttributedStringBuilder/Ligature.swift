import Foundation

/// The ligature options for characters in an attributed string.
public enum Ligature: NSNumber {

    /// No ligature.
    case none
    /// Default ligature for the corresponding characters.
    case `default`

    #if !os(iOS)
    /// All ligatures is unsupported on iOS.
    case all
    #endif
}
