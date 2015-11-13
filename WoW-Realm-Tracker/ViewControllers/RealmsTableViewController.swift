import UIKit

class RealmsTableViewController: UITableViewController {
    var searchController: UISearchController!
    var viewModel: RealmsListViewModel?

    let dataSource = RealmsDataSource()
    let searchResultsController = SearchResultsController()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.viewController = self
        tableView.delegate = dataSource
        tableView.dataSource = dataSource

        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}

extension RealmsTableViewController: RealmsListController {}

extension RealmsTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            let filteredRealmsViewModel = viewModel!.filter(term)
            searchResultsController.viewModel = filteredRealmsViewModel
        }
    }
}

extension RealmsTableViewController: UISearchControllerDelegate {
    func didDismissSearchController(searchController: UISearchController) {
        tableView.reloadData()
    }
}
