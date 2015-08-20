import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var realmsTable: WKInterfaceTable!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        loadRealms()
    }

    override func willActivate() {
        super.willActivate()
        loadRealms()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    private func loadRealms() {
        let defaults = NSUserDefaults(suiteName: "group.com.damiangalarza.realmtracker")
        let realms = defaults?.objectForKey("favorites") as! [String]

        realmsTable.setNumberOfRows(realms.count, withRowType: "Realm")

        var index: Int;
        for index = 0; index < realms.count; index++ {
            let row = realmsTable.rowControllerAtIndex(index) as! RealmRowController
            row.nameLabel.setText(realms[index])
            row.statusImage.setImageNamed("Available")
        }
    }
}
