import UIKit
import Runes

class RealmsTableViewController: UITableViewController {
    private let cellIdentifier = "Realm"

    @IBOutlet weak var searchBar: UISearchBar!

    var favoriteRealmsController: FavoriteRealmsController?
    var searchResultsController = UISearchController()
    var searchResultsUpdater: RealmSearchController?
    var realms = [Realm]()

    override func viewDidLoad() {
        super.viewDidLoad()
        realms = favoriteRealmsController.map { $0.realms } ?? []
        searchResultsUpdater = RealmSearchController(realms: realms, viewController: self)
        searchBar.delegate = self
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
        let realm = realms[indexPath.row]
        let isFavorited = favoriteRealmsController >>- { $0.realmIsFavorited(realm) } ?? false

        if isFavorited {
            favoriteRealmsController?.unfavorite(realm)
        } else {
            favoriteRealmsController?.addFavorite(realm)
        }

        tableView.reloadData()
    }
}

extension RealmsTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        searchBar.showsCancelButton = true
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchResultsUpdater?.search(searchText)
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension RealmsTableViewController: RealmsSearchDelegate {
    func realmsFiltered(filteredRealms: [Realm]) {
        realms = filteredRealms
        tableView.reloadData()
    }
}