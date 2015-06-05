import UIKit
import Runes

class BaseRealmsTableViewController: UITableViewController {
    let cellIdentifier = "Realm"

    var realms = [Realm]()
    var favoriteRealmsController: FavoriteRealmsController?

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

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
}
