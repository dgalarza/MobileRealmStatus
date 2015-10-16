import UIKit
import Runes
import Result

class FavoritesViewController: UITableViewController {
    private let cellIdentifier = "Realm"
    var controller: FavoriteRealmsController?

    private var favoriteRealms: [Realm] {
        get {
            return (controller >>- { $0.favoriteRealms }) ?? []
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        toggleEmptyState()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let realmsViewController = segue.destinationViewController as! RealmsTableViewController
        realmsViewController.controller = controller
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

        cell.viewModel = RealmViewModel(realm: realm, favoritesController: controller!)
        cell.includeStatusImage()

        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let realm = favoriteRealms[indexPath.row]
            controller?.unfavorite(realm)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            toggleEmptyState()
        }
    }

    private func toggleEmptyState() {
        if controller?.shouldShowEmptyState() ?? true {
            displayEmptyState()
            navigationItem.leftBarButtonItem = .None
        } else {
            hideEmptyState()
            navigationItem.leftBarButtonItem = editButtonItem()
        }
    }

    private func displayEmptyState() {
        let emptyStateViewController = EmptyStateViewController.create()
        emptyStateViewController.moveToParent(self) { self.tableView.backgroundView = $0 }
    }

    private func hideEmptyState() {
        let emptyStateViewController = childViewControllers.last as? EmptyStateViewController
        emptyStateViewController?.removeFromParent { self.tableView.backgroundView = .None }
    }
}

extension FavoritesViewController: RealmsDelegate {
    func receivedRealms(response: Result<[Realm], NSError>) {
        let controller = response.map { FavoriteRealmsController(realms: $0) }

        if let favoritesController = controller.value {
            self.controller = favoritesController
            tableView.reloadData()
        }

        refreshControl?.endRefreshing()
        SVProgressHUD.dismiss()
    }
}