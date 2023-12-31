import Foundation

// swiftlint:disable identifier_name

/// Creates an attributed string with a space character.
/// - Parameters:
///   - spacing: The type of whitespace as defined in `Spacing`.
/// - Returns: An attributed string of a whitespace.
public func Space(_ spacing: Spacing = .standard) -> NSAttributedString {
    NSAttributedString().space(spacing)
}

// swiftlint:enable identifier_name
