import RealmTracker
import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    @IBOutlet weak var realmsTable: WKInterfaceTable!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        RealmsController(realmsDelegate: self).retrieveRealms()
    }

    private func displayRealms(favoritedRealms: [Realm]) {
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
        let favoritesController = FavoriteRealmsController(realms: realms)
        let favoritedRealms = favoritesController.favoriteRealms

        displayRealms(favoritedRealms)
    }
}
