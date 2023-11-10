import Foundation
import NSAttributedStringBuilder

public enum ListItemFactory {

    public static func makeListItems() -> [ListItem] {
        [
            ListItem(text: NSAttributedString {
                AImage.globe()
                    .image(systemName: "star.fill", bounds: .init(origin: .zero, size: .init(width: 100, height: 90)))
                    .image(.globe())
                    .foregroundColor(.systemOrange)
                    .alignment(.center)

                Newline()

                "Hello, world!"
                    .alignment(.center)
            }),
            ListItem(text: NSAttributedString {
                "Hello"
                    .italic()

                Space()

                "SwiftUI!"
                    .bold()
                    .foregroundColor(.systemPurple)
            }),
            ListItem(text: NSAttributedString {
                "Hello"
                    .foregroundColor(.systemOrange)
                    .underline()
                    .italic()
                    .kerning(1.5)

                Space()

                "World."
                    .foregroundColor(.systemRed)
                    .bold()
            }),
            ListItem(
                text: "Eine wunderbare Heiterkeit hat meine ganze Seele eingenommen, gleich den süßen Frühlingsmorgen, die ich mit ganzem Herzen genieße. Ich bin allein und freue mich meines Lebens in dieser Gegend, die für solche Seelen geschaffen ist wie die meine. Ich bin so glücklich, mein Bester, so ganz in dem Gefühle von ruhigem Dasein versunken, daß meine Kunst darunter leidet."
                    .hyphenationFactor(1.0)
                    .language(.german)
                    .lineBreakMode(.byWordWrapping)
                    .font(.systemFont(ofSize: 20))
            )
        ]
    }
}
