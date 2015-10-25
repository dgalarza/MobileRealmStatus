import UIKit
import Result

class FavoritesViewController: UITableViewController {
    var controller: FavoriteRealmsController?
    let favoritesDataSource = FavoritesDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesDataSource.viewController = self

        tableView.dataSource = favoritesDataSource
        tableView.delegate = favoritesDataSource
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

    func toggleEmptyState() {
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
