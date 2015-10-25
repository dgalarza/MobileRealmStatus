import UIKit

class FavoritesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let cellIdentifier = "Realm"
    weak var viewController: FavoritesViewController!

    private var favoriteRealms: [Realm] {
        return viewController.controller.flatMap { $0.favoriteRealms } ?? []
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRealms.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealmCell
        let realm = favoriteRealms[indexPath.row]

        cell.viewModel = RealmViewModel(realm: realm, favoritesController: viewController.controller!)
        cell.includeStatusImage()

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
            let realm = favoriteRealms[indexPath.row]
            viewController.controller?.unfavorite(realm)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            viewController.toggleEmptyState()
        }
    }
}
