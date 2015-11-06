import UIKit
import Result

class FavoritesViewController: UITableViewController {
    var viewModel: RealmsListViewModel?
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
        realmsViewController.viewModel = viewModel
    }

    @IBAction func refresh(sender: UIRefreshControl) {
        let realmsController = RealmsController(realmsDelegate: self)
        realmsController.retrieveRealms()
    }

    func toggleEmptyState() {
        if viewModel?.hasFavorites ?? false {
            hideEmptyState()
            navigationItem.leftBarButtonItem = editButtonItem()
        } else {
            displayEmptyState()
            navigationItem.leftBarButtonItem = .None
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
        let viewModel = response.map { RealmsListViewModel(realms: $0) }

        if let favoritesViewModel = viewModel.value {
            self.viewModel = favoritesViewModel
            tableView.reloadData()
        }

        refreshControl?.endRefreshing()
        SVProgressHUD.dismiss()
    }
}
