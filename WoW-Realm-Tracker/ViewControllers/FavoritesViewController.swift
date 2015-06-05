import UIKit
import Runes

class FavoritesViewController: UITableViewController {
    private let cellIdentifier = "Realm"
    var favoriteRealmsController: FavoriteRealmsController?

    private var favoriteRealms: [Realm] {
        get {
            return (favoriteRealmsController >>- { $0.favoriteRealms }) ?? []
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let realmsViewController = segue.destinationViewController as! RealmsTableViewController
        realmsViewController.favoriteRealmsController = favoriteRealmsController
    }

    @IBAction func refresh(sender: UIRefreshControl) {
        let realmsController = RealmsController(realmsDelegate: self)
        realmsController.retrieveRealms()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRealms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealmCell
        let realm = favoriteRealms[indexPath.row]

        cell.viewModel = RealmViewModel(realm: realm, favoritesController: favoriteRealmsController!)
        cell.includeStatusImage()

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let realm = favoriteRealms[indexPath.row]
            favoriteRealmsController?.unfavorite(realm)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

extension FavoritesViewController: RealmsDelegate {
    func receivedRealms(realms: [Realm]) {
        favoriteRealmsController = FavoriteRealmsController(realms: realms)
        refreshControl?.endRefreshing()
        tableView.reloadData()
        SVProgressHUD.dismiss()
    }
}