#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import NSAttributedStringBuilder

public extension AImage {

    static func globe() -> AImage {
        #if canImport(UIKit)
        guard let image = UIImage(systemName: "globe") else {
            assertionFailure("Unknown image.")
            return UIImage()
        }
        return image
        #elseif canImport(AppKit)
        guard let image = NSImage(systemSymbolName: "globe", accessibilityDescription: "globe") else {
            assertionFailure("Unknown image.")
            return NSImage()
        }
        return image
        #endif
    }
}
