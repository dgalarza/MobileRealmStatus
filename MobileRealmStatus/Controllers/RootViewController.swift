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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        let realm = favoriteRealms[indexPath.row]

        cell.textLabel?.text = realm.name
        cell.detailTextLabel?.text = realm.displayType()
        
        if let imageView = cell.imageView {
            let image = UIImage(named: "Available")
            imageView.image = image
            
        }

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
        let api = RealmsApi()

        refreshControl?.beginRefreshing()

        api.realmStatus() { (realms: [Realm]) -> () in
            self.realms = realms
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
}
