import UIKit

private let cellIdentifier = "Realm"

class RealmsDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    weak var viewController: RealmsListController?

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewController?.viewModel?.count ?? 0
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealmCell

        if let realm = viewController?.viewModel?.viewModelForCellAtIndexPath(indexPath) {
            cell.viewModel = realm
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewController?.viewModel?.toggleFavoriteForRealmAtIndexPath(indexPath)
        tableView.reloadData()
    }
}
