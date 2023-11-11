import Foundation

@resultBuilder
public enum NSAttributedStringBuilder {

    public static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        components.reduce(into: NSMutableAttributedString()) { result, element in
            result.append(element)
        }
    }
}

public extension NSAttributedString {

    /// Builds an attributed string from given attributed strings provided by the result builder.
    func callAsFunction(@NSAttributedStringBuilder _ builder: () -> NSAttributedString) -> NSAttributedString {
        builder()
    }
}
