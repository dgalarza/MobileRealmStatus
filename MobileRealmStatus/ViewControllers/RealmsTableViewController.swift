import UIKit
import Runes

class RealmsTableViewController: UITableViewController {
    private let cellIdentifier = "Realm"

    var favoriteRealmsController: FavoriteRealmsController?
    var searchResultsController = UISearchController()

    var realms: [Realm] {
        get {
            return favoriteRealmsController.map { $0.realms } ?? []
        }
    }

    @IBAction func displaySearch(sender: UIBarButtonItem) {
        tableView.tableHeaderView = searchResultsController.searchBar
        searchResultsController.searchBar.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsController = setupSearch()
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealmCell
        let realm = realms[indexPath.row]
        let isFavorited = favoriteRealmsController >>- { $0.realmIsFavorited(realm) } ?? false

        cell.viewModel = realm

        if isFavorited {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let favorites = FavoritesList.sharedFavoritesList
        let realm = realms[indexPath.row]
        let isFavorited = favoriteRealmsController >>- { $0.realmIsFavorited(realm) } ?? false

        if isFavorited {
            favoriteRealmsController?.unfavorite(realm)
        } else {
            favoriteRealmsController?.addFavorite(realm)
        }

        tableView.reloadData()
    }

    private func setupSearch() -> UISearchController {
        let resultsController = SearchResultsViewController()
        resultsController.favoriteRealmsController = favoriteRealmsController

        let searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = resultsController
        searchController.dimsBackgroundDuringPresentation = false

        let searchBar = searchController.searchBar
        searchBar.sizeToFit()

        return searchController
    }
}
