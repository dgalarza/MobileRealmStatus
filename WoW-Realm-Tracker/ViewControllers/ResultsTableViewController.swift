import UIKit
import Runes

class ResultsTableViewController: BaseRealmsTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(RealmCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

extension ResultsTableViewController: RealmsSearchDelegate {
    func realmsFiltered(filteredRealms: [Realm]) {
        self.realms = filteredRealms
        tableView.reloadData()
    }
}
