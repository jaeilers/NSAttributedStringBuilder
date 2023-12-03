import Foundation

@resultBuilder
public enum NSAttributedStringBuilder {

    public static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        components.reduce(into: NSMutableAttributedString()) { result, element in
            result.append(element)
        }
    }

    public static func buildOptional(_ component: NSAttributedString?) -> NSAttributedString {
        component ?? NSAttributedString()
    }

    public static func buildEither(first component: NSAttributedString) -> NSAttributedString {
        component
    }

    public static func buildEither(second component: NSAttributedString) -> NSAttributedString {
        component
    }

    public static func buildLimitedAvailability(_ component: NSAttributedString) -> NSAttributedString {
        component
    }
}

public extension NSAttributedString {

    /// Initializes an attributed string from given attributed strings provided by the result builder.
    convenience init(@NSAttributedStringBuilder _ builder: () -> NSAttributedString) {
        self.init(attributedString: builder())
    }
}
