import UIKit

private let cellIdentifier = "Realm"

class RealmsTableViewController: UITableViewController {
    var searchController: UISearchController!
    var viewModel: RealmsListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
//        tableView.tableHeaderView = searchController.searchBar
//        definesPresentationContext = true
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealmCell

        if let realm = viewModel?.viewModelForCellAtIndexPath(indexPath) {
            cell.viewModel = realm
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel?.toggleFavoriteForRealmAtIndexPath(indexPath)
        tableView.reloadData()
    }
}
