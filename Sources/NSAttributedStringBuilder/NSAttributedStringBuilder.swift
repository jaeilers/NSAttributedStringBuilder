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

    /// Initializes an attributed string from given attributed strings provided by the result builder.
    convenience init(@NSAttributedStringBuilder _ builder: () -> NSAttributedString) {
        self.init(attributedString: builder())
    }
}
