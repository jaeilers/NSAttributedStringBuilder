import Core
import UIKit

final class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    private var dataSource: UITableViewDiffableDataSource<Int, ListItem>?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        setupTableView()
        setupDataSource()
    }

    private func setupTableView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupDataSource() {
        dataSource = DataSourceFactory.makeDataSource(with: tableView)

        let items = ListItemFactory.makeListItems()
        var snapshot = NSDiffableDataSourceSnapshot<Int, ListItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)

        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

private enum DataSourceFactory {

    static func makeDataSource(with tableView: UITableView) -> UITableViewDiffableDataSource<Int, ListItem> {
        UITableViewDiffableDataSource<Int, ListItem>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none

            var config = cell.defaultContentConfiguration()
            config.attributedText = item.text
            cell.contentConfiguration = config

            return cell
        }
    }
}
