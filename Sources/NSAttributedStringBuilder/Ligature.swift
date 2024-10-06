import Foundation

/// The ligature options for characters in an attributed string.
public enum Ligature: NSNumber, Hashable, Codable, Sendable {

    /// Indicates that no ligatures are used.
    case none
    /// Indicates the use of the default ligatures for the corresponding characters.
    case `default`

    #if !os(iOS)
    /// Indicates the use of all ligatures. All ligatures is unsupported on iOS.
    case all
    #endif
}
