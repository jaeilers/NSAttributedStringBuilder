import Foundation
import NSAttributedStringBuilder

extension Attributes {

    func isEqual(to other: Attributes) -> Bool {
        NSDictionary(dictionary: self).isEqual(to: other)
    }
}
