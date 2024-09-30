#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif
@testable import NSAttributedStringBuilder
import Testing

extension AImage {

    static func pencil() throws -> AImage {
        #if canImport(UIKit)
        return try #require(UIImage(systemName: "pencil"))
        #elseif canImport(AppKit)
        return try #require(NSImage(systemSymbolName: "pencil", accessibilityDescription: nil))
        #else
        return AImage()
        #endif
    }

    static func star() throws -> AImage {
        #if canImport(UIKit)
        return try #require(UIImage(systemName: "star"))
        #elseif canImport(AppKit)
        return try #require(NSImage(systemSymbolName: "star", accessibilityDescription: nil))
        #else
        return AImage()
        #endif
    }
}
