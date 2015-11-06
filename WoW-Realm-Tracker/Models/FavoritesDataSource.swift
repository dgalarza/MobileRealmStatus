import UIKit

class FavoritesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let cellIdentifier = "Realm"
    weak var viewController: FavoritesViewController!

    var viewModel: RealmsListViewModel? {
        return viewController.viewModel
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.favoritesCount ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealmCell

        if let realm = viewModel?.favoritedViewModelForCellAtIndexPath(indexPath) {
            cell.viewModel = realm
            cell.includeStatusImage()
        }

        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            viewModel?.removeFavoritedRealmAtIndexPath(indexPath)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            viewController.toggleEmptyState()
        }
    }
}
