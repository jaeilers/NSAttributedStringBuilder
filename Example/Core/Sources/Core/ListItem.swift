import Foundation

public struct ListItem: Hashable, Identifiable, Sendable {

    // MainActor closure until `NSAttributedString` conforms to `Sendable` (hopefully)
    public let text: @MainActor () -> NSAttributedString
    public let id = UUID()

    public init(text: @MainActor @escaping () -> NSAttributedString) {
        self.text = text
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
