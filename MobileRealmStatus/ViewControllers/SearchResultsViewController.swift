import UIKit
import Runes

class SearchResultsViewController: UITableViewController {
    private let cellIdentifier = "Realm"
    private var filteredRealms = [Realm]()

    var favoriteRealmsController: FavoriteRealmsController?

    lazy var realmSearchController: RealmSearchController = {
        let realms = self.favoriteRealmsController.map { $0.realms } ?? []
        return RealmSearchController(realms: realms, searchDelegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(RealmCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRealms.count
    }

    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let favorites = FavoritesList.sharedFavoritesList
        let realm = filteredRealms[indexPath.row]
        let isFavorited = favoriteRealmsController >>- { $0.realmIsFavorited(realm) } ?? false

        if isFavorited {
            favoriteRealmsController?.unfavorite(realm)
        } else {
            favoriteRealmsController?.addFavorite(realm)
        }

        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealmCell
        let realm = filteredRealms[indexPath.row]
        let isFavorited = favoriteRealmsController >>- { $0.realmIsFavorited(realm) } ?? false

        cell.viewModel = realm

        if isFavorited {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }

        return cell
    }
}

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        realmSearchController.search(searchText)
    }
}

extension SearchResultsViewController: RealmsSearchDelegate {
    func realmsFiltered(realms: [Realm]) {
        filteredRealms = realms
        tableView.reloadData()
    }
}
