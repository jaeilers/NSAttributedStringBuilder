import AppKit
import Cocoa
import Core

final class ViewController: NSViewController {

    @IBOutlet private var tableView: NSTableView!

    private var dataSource: NSTableViewDiffableDataSource<Int, ListItem>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDataSource()
    }

    private func setupDataSource() {
        dataSource = DataSourceFactory.makeDataSource(for: tableView)

        let items = ListItemFactory.makeListItems()
        var snapshot = NSDiffableDataSourceSnapshot<Int, ListItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

private enum DataSourceFactory {

    static func makeDataSource(for tableView: NSTableView) -> NSTableViewDiffableDataSource<Int, ListItem> {
        NSTableViewDiffableDataSource<Int, ListItem>(tableView: tableView) { tableView, _, _, item in
            let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("cell"), owner: nil) as? NSTableCellView
            cell?.textField?.attributedStringValue = item.text
            return cell ?? NSTableCellView()
        }
    }
}
