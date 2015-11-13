import UIKit

class SearchResultsController: UITableViewController {
    var viewModel: RealmsListViewModel? {
        didSet {
            tableView.reloadData()
        }
    }

    let dataSource = RealmsDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(RealmCell.classForCoder(), forCellReuseIdentifier: "Realm")

        dataSource.viewController = self
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
    }
}

extension SearchResultsController: RealmsListController {}
