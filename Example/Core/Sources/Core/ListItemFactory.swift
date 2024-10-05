import Foundation
import NSAttributedStringBuilder

public enum ListItemFactory: Sendable {

    public static func makeListItems() -> [ListItem] {
        [
            ListItem {
                NSAttributedString {
                    #if !os(watchOS)
                    AImage.globe()
                        .image(systemName: "star.fill", bounds: .init(origin: .zero, size: .init(width: 100, height: 90)))
                        .image(.globe())
                        .foregroundColor(.coreOrange)
                        .alignment(.center)
                        .underline()

                    Newline()
                    #endif

                    "Hello,"
                        .alignment(.center)
                        .italic()
                        .bold()

                    Space()

                    "world!"
                        .foregroundColor(.coreRed)
                        .bold()
                        .strikethrough(color: .coreOrange)
                        .backgroundColor(.coreYellow)
                }
            },
            ListItem {
                NSAttributedString {
                    "Hello"
                        .italic()

                    Space()

                    "SwiftUI!"
                        .bold()
                        .foregroundColor(.corePurple)
                }
            },
            ListItem { L10n.monospacedText.foregroundColor(.coreBlue).monospaced() },
            ListItem {
                NSAttributedString {
                    "Hello"
                        .foregroundColor(.coreOrange)
                        .underline()
                        .italic()
                        .kerning(1.5)

                    Space()

                    "World."
                        .foregroundColor(.coreRed)
                        .bold()
                }
            },
            ListItem {
                NSAttributedString {
                    let attributes = Attributes()
                        .font(.systemFont(ofSize: 16))
                        .italic()
                        .underline()

                    "Hello"
                        .addingAttributes(attributes)
                        .foregroundColor(.coreBlue)

                    Space()

                    "World"
                        .addingAttributes(attributes)
                        .foregroundColor(.coreTeal)

                    Space()

                    "again!"
                        .addingAttributes(attributes)
                        .foregroundColor(.coreGreen)
                }
            },
            ListItem {
                NSAttributedString {
                    L10n.pangramEnglish
                        .language(.english)
                        .font(.systemFont(ofSize: 30))
                        .stroke()
                        .foregroundColor(.coreTeal)
                }
            },
            ListItem { L10n.condensedText.condensed().alignment(.center) },
            ListItem {
                NSAttributedString {
                    L10n.pangramGreek
                        .kerning(5.0)
                        .language(.greek)
                }
            },
            ListItem {
                NSAttributedString {
                    "ABCDEF".tracking(-3)
                    Newline()
                    "ABCDEF".tracking(0)
                    Newline()
                    "ABCDEF".tracking(3)
                }
            },
            ListItem {
                L10n.dummyTextGerman
                    .hyphenationFactor(1.0)
                    .language(.german)
                    .lineBreakMode(.byWordWrapping)
                    .lineBreakStrategy(.standard)
                    .font(.systemFont(ofSize: 20))
            },
            ListItem {
                NSAttributedString {
                    L10n.pangramEnglish
                        .writingDirection(.rightToLeftDirectionOverride)
                        .baseWritingDirection(.rightToLeft)

                    Newline()

                    "—"
                        .newline()
                        .text(L10n.pangramArabic)
                        .font(.systemFont(ofSize: 40))
                        .baseWritingDirection(.rightToLeft)
                        .language(.arabic)

                    Newline()

                    "—"
                        .font(.systemFont(ofSize: 40))
                        .baseWritingDirection(.leftToRight)

                    Newline()

                    L10n.pangramHebrew
                        .baseWritingDirection(.rightToLeft)
                }
            }
        ]
    }
}

// MARK: - Helpers

private extension AColor {

    static var coreBlue: AColor {
        #if os(watchOS)
        return AColor.blue
        #else
        return AColor.systemBlue
        #endif
    }

    static var coreRed: AColor {
        #if os(watchOS)
        return AColor.red
        #else
        return AColor.systemRed
        #endif
    }

    static var coreTeal: AColor {
        #if os(watchOS)
        return AColor(red: 0.25098039215686274, green: 0.7843137254901961, blue: 0.8784313725490196, alpha: 1.0)
        #else
        return AColor.systemTeal
        #endif
    }

    static var coreGreen: AColor {
        #if os(watchOS)
        return AColor.green
        #else
        return AColor.systemGreen
        #endif
    }

    static var coreOrange: AColor {
        #if os(watchOS)
        return AColor.orange
        #else
        return AColor.systemOrange
        #endif
    }

    static var corePurple: AColor {
        #if os(watchOS)
        return AColor.purple
        #else
        return AColor.systemPurple
        #endif
    }

    static var coreYellow: AColor {
        #if os(watchOS)
        return AColor.yellow
        #else
        return AColor.systemYellow
        #endif
    }
}
