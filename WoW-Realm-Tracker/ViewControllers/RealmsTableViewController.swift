import UIKit
import Runes

class RealmsTableViewController: UITableViewController {
    private let cellIdentifier = "Realm"

    @IBOutlet weak var searchBar: UISearchBar!

    var controller: FavoriteRealmsController?
    var searchResultsUpdater: RealmSearchController?
    var realms = [Realm]()

    override func viewDidLoad() {
        super.viewDidLoad()
        realms = controller.map { $0.realms } ?? []
        searchResultsUpdater = RealmSearchController(realms: realms, viewController: self)
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realms.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealmCell
        let realm = realms[indexPath.row]

        cell.viewModel = RealmViewModel(realm: realm, favoritesController: controller!)

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let realm = realms[indexPath.row]
        let isFavorited = (controller >>- { $0.realmIsFavorited(realm) }) ?? false

        if isFavorited {
            controller?.unfavorite(realm)
        } else {
            controller?.addFavorite(realm)
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
        realms = searchResultsUpdater?.realms ?? []
        tableView.reloadData()
    }
}

extension RealmsTableViewController: RealmsSearchDelegate {
    func realmsFiltered(filteredRealms: [Realm]) {
        realms = filteredRealms
        tableView.reloadData()
    }
}
