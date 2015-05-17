import UIKit
import Runes

class RealmsTableViewController: UITableViewController {
    private let cellIdentifier = "Realm"
    private var filteredRealms = [Realm]()

    var favoriteRealmsController: FavoriteRealmsController?
    var searchResultsController = UISearchController()

    var dataSource: [Realm] {
        get {
            if searchResultsController.active {
                return filteredRealms
            } else {
                return favoriteRealmsController.map { $0.realms } ?? []
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsController = setupSearch()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealmCell
        let realm = dataSource[indexPath.row]
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
        let realm = dataSource[indexPath.row]
        let isFavorited = favoriteRealmsController >>- { $0.realmIsFavorited(realm) } ?? false

        if isFavorited {
            favoriteRealmsController?.unfavorite(realm)
        } else {
            favoriteRealmsController?.addFavorite(realm)
        }

        tableView.reloadData()
    }

    private func setupSearch() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false

        let searchBar = searchController.searchBar
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar

        return searchController
    }
}

extension RealmsTableViewController: UISearchResultsUpdating  {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchText)
        let realms = favoriteRealmsController.map { $0.realms } ?? []

        filteredRealms = realms.filter { searchPredicate.evaluateWithObject($0.name) }

        tableView.reloadData()
    }
}
