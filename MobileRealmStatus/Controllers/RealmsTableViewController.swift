import UIKit

class RealmsTableViewController: UITableViewController, UISearchResultsUpdating {
    private let cellIdentifier = "Realm"
    var realms = [Realm]()
    var filteredRealms = [Realm]()
    var searchResultsController = UISearchController()

    var dataSource: [Realm] {
        get {
            if searchResultsController.active {
                return filteredRealms
            } else {
                return realms
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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell

        let realm = dataSource[indexPath.row]
        cell.textLabel?.text = realm.name
        cell.detailTextLabel?.text = realm.displayType()
        
        if realmIsFavorited(realm) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let favorites = FavoritesList.sharedFavoritesList
        let realm = dataSource[indexPath.row]

        if realmIsFavorited(realm) {
            favorites.removeFavorite(realm.name)
        } else {
            favorites.addFavorite(realm.name)
        }

        tableView.reloadData()
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchText)

        filteredRealms = realms.filter { searchPredicate.evaluateWithObject($0.name) }

        tableView.reloadData()
    }

    // MARK: Private

    private func setupSearch() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false

        let searchBar = searchController.searchBar
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar

        return searchController
    }

    private func realmIsFavorited(realm: Realm) -> Bool {
        let favorites = FavoritesList.sharedFavoritesList.favorites
        return contains(favorites, realm.name)
    }
}
