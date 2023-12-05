import Foundation
import NSAttributedStringBuilder

public enum ListItemFactory {

    public static func makeListItems() -> [ListItem] {
        [
            ListItem(text: NSAttributedString {
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
            }),
            ListItem(text: NSAttributedString {
                "Hello"
                    .italic()

                Space()

                "SwiftUI!"
                    .bold()
                    .foregroundColor(.corePurple)
            }),
            ListItem(text: "Here is some monospaced text.".foregroundColor(.coreBlue).monospaced()),
            ListItem(text: NSAttributedString {
                "Hello"
                    .foregroundColor(.coreOrange)
                    .underline()
                    .italic()
                    .kerning(1.5)

                Space()

                "World."
                    .foregroundColor(.coreRed)
                    .bold()
            }),
            ListItem(
                text: "Eine wunderbare Heiterkeit hat meine ganze Seele eingenommen, gleich den süßen Frühlingsmorgen, die ich mit ganzem Herzen genieße. Ich bin allein und freue mich meines Lebens in dieser Gegend, die für solche Seelen geschaffen ist wie die meine. Ich bin so glücklich, mein Bester, so ganz in dem Gefühle von ruhigem Dasein versunken, daß meine Kunst darunter leidet."
                    .hyphenationFactor(1.0)
                    .language(.german)
                    .lineBreakMode(.byWordWrapping)
                    .lineBreakStrategy(.standard)
                    .font(.systemFont(ofSize: 20))
            ),
            ListItem(text: NSAttributedString {
                "The quick brown fox jumps over the lazy dog."
                    .language(.english)
                    .font(.systemFont(ofSize: 30))
                    .stroke()
                    .foregroundColor(.coreTeal)
            }),
            ListItem(text: NSAttributedString {
                "The quick brown fox jumps over the lazy dog."
                    .writingDirection(.rightToLeftDirectionOverride)
                    .baseWritingDirection(.rightToLeft)

                Newline()

                "—"
                    .newline()
                    .text("نصٌّ حكيمٌ لهُ سِرٌّ قاطِعٌ وَذُو شَأنٍ عَظيمٍ مكتوبٌ على ثوبٍ أخضرَ ومُغلفٌ بجلدٍ أزرق")
                    .font(.systemFont(ofSize: 40))
                    .baseWritingDirection(.rightToLeft)
                    .language(.arabic)

                Newline()

                "—"
                    .font(.systemFont(ofSize: 40))
                    .baseWritingDirection(.leftToRight)

                Newline()

                "דג סקרן שט בים מאוכזב ולפתע מצא חברה"
                    .baseWritingDirection(.rightToLeft)
            })
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
