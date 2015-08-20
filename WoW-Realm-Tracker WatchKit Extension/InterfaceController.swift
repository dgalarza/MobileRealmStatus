import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    var realms = [String]()

    @IBOutlet weak var realmsTable: WKInterfaceTable!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        loadRealms()
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    private func loadRealms() {
        self.realms = ["Arthas", "Skullcrusher"]
        realmsTable.setNumberOfRows(realms.count, withRowType: "Realm")

        let availableImage = UIImage(named: "Available")

        var index: Int;
        for index = 0; index < realms.count; index++ {
            let row = realmsTable.rowControllerAtIndex(index) as! RealmRowController
            row.nameLabel.setText(realms[index])
            row.statusImage.setImage(availableImage)
        }
    }
}
