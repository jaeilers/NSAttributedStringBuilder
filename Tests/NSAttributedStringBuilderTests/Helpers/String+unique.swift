import Foundation

extension String {
    /// - Returns: A unique string powered by `UUID`.
    static func unique() -> String {
        UUID().uuidString
    }
}
