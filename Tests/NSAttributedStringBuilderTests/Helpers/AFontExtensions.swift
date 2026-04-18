#if canImport(AppKit)
import AppKit
typealias AFontTraits = NSFontDescriptor.SymbolicTraits
#elseif canImport(UIKit)
import UIKit
typealias AFontTraits = UIFontDescriptor.SymbolicTraits
#endif
import NSAttributedStringBuilder

#if canImport(AppKit) || canImport(UIKit)
extension AFont {

    func applying(traits: AFontTraits) -> AFont? {
        #if canImport(AppKit)
        let descriptor = fontDescriptor.withSymbolicTraits([traits, fontDescriptor.symbolicTraits])
        #elseif canImport(UIKit)
        guard let descriptor = fontDescriptor.withSymbolicTraits([traits, fontDescriptor.symbolicTraits]) else {
            return nil
        }
        #endif
        return AFont(descriptor: descriptor, size: 0.0)
    }
}
#endif
