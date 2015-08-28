import RealmTracker
import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    @IBOutlet weak var realmsTable: WKInterfaceTable!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        RealmsController(realmsDelegate: self).retrieveRealms()
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    private func displayRealms(realms: [Realm]) {
        let defaults = NSUserDefaults(suiteName: "group.com.damiangalarza.realmtracker")
        let favorites = defaults?.objectForKey("favorites") as! [String]

        let favoritedRealms = realms.filter { contains(favorites, $0.name) }
        realmsTable.setNumberOfRows(favoritedRealms.count, withRowType: "Realm")

        var index: Int;
        for index = 0; index < favoritedRealms.count; index++ {
            let row = realmsTable.rowControllerAtIndex(index) as! RealmRowController
            let realm = favoritedRealms[index]
            row.nameLabel.setText(realm.name)
        }
    }
}

extension InterfaceController: RealmsDelegate {
    func receivedRealms(realms: [Realm]) {
        displayRealms(realms)
    }
}
