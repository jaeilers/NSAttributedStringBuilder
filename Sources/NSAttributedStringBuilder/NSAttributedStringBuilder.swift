import Foundation

@resultBuilder
public struct NSAttributedStringBuilder {

    public static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        components.reduce(into: NSMutableAttributedString()) { result, element in
            result.append(element)
        }
    }
}

public extension NSAttributedString {

    func callAsFunction(@NSAttributedStringBuilder _ builder: () -> NSAttributedString) -> NSAttributedString {
        builder()
    }
}
