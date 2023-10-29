@testable import NSAttributedStringBuilder
import XCTest

extension AImage {

    static func pencil() throws -> AImage {
        #if canImport(UIKit)
        return try XCTUnwrap(UIImage(systemName: "pencil"))
        #elseif canImport(AppKit)
        return try XCTUnwrap(NSImage(systemSymbolName: "pencil", accessibilityDescription: nil))
        #else
        return AImage()
        #endif
    }

    static func star() throws -> AImage {
        #if canImport(UIKit)
        return try XCTUnwrap(UIImage(systemName: "star"))
        #elseif canImport(AppKit)
        return try XCTUnwrap(NSImage(systemSymbolName: "star", accessibilityDescription: nil))
        #else
        return AImage()
        #endif
    }
}
