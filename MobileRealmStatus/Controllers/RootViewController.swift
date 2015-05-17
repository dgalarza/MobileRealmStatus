import UIKit

class RootViewController: UITableViewController {
    private let cellIdentifier = "Realm"
    private var realms = [Realm]()

    var favoriteRealms: [Realm] {
        get {
            let favorites = FavoritesList.sharedFavoritesList.favorites
            return realms.filter { contains(favorites, $0.name) }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveRealms()
    }

    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let realmsViewController = segue.destinationViewController as! RealmsTableViewController
        realmsViewController.realms = realms
    }

    @IBAction func refresh(sender: UIRefreshControl) {
        retrieveRealms()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRealms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealmCell
        let realm = favoriteRealms[indexPath.row]

        cell.viewModel = realm

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let realm = favoriteRealms[indexPath.row]
            FavoritesList.sharedFavoritesList.removeFavorite(realm.name)

            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    private func retrieveRealms() {
        refreshControl?.beginRefreshing()

        let realmsController = RealmsController(realmsDelegate: self)
        realmsController.retrieveRealms()
    }
}

extension RootViewController: RealmsDelegate {
    func receivedRealms(realms: [Realm]) {
        self.realms = realms
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
}