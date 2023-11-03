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
            })
        ]
    }
}
