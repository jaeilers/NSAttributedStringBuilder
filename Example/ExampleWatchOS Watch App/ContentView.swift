import Core
import SwiftUI

struct ContentView: View {

    private let items = ListItemFactory.makeListItems()

    var body: some View {
        List(items, rowContent: makeRow)
    }

    private func makeRow(_ item: ListItem) -> some View {
        Text(AttributedString(item.text))
    }
}

#Preview {
    ContentView()
}
