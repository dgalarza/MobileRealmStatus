import UIKit
import Runes

class RealmsTableViewController: UITableViewController {
    private let cellIdentifier = "Realm"

    @IBOutlet weak var searchBar: UISearchBar!

    var favoriteRealmsController: FavoriteRealmsController?
    var searchResultsController: UISearchController?
    var searchResultsUpdater: RealmSearchController?
    var realms = [Realm]()

    override func viewDidLoad() {
        super.viewDidLoad()
        realms = favoriteRealmsController.map { $0.realms } ?? []
        searchResultsUpdater = RealmSearchController(realms: realms, searchDelegate: self)

        searchResultsController = UISearchController(searchResultsController: nil)
        searchResultsController?.dimsBackgroundDuringPresentation = false
        searchResultsController?.searchResultsUpdater = searchResultsUpdater!
        searchResultsController?.searchBar.sizeToFit()

        tableView.tableHeaderView = searchResultsController?.searchBar

        definesPresentationContext = true
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.translucent = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.translucent = false
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealmCell
        let realm = realms[indexPath.row]

        cell.viewModel = RealmViewModel(realm: realm, favoritesController: favoriteRealmsController!)

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let realm = realms[indexPath.row]
        let isFavorited = (favoriteRealmsController >>- { $0.realmIsFavorited(realm) }) ?? false

        if isFavorited {
            favoriteRealmsController?.unfavorite(realm)
        } else {
            favoriteRealmsController?.addFavorite(realm)
        }

        tableView.reloadData()
    }
}

extension RealmsTableViewController: RealmsSearchDelegate {
    func realmsFiltered(filteredRealms: [Realm]) {
        realms = filteredRealms
        tableView.reloadData()
    }
}
