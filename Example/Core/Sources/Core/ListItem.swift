import Foundation

public struct ListItem: Hashable, Identifiable {

    public let text: NSAttributedString
    public let id = UUID()

    public init(text: NSAttributedString) {
        self.text = text
    }
}
