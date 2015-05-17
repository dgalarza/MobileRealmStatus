import UIKit

struct AppearanceManager {
    static func applyCustomAppearance() {
        applyNavBarStyles()
        applyTableStyles()
    }

    static func customizeRealmCell(cell: RealmCell) {
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.textColor = UIColor.captionGray()
    }

    private static func applyNavBarStyles() {
        let navigationBarAppearnce = UINavigationBar.appearance()
        navigationBarAppearnce.translucent = false
        navigationBarAppearnce.barTintColor = UIColor.backgroundGray()
        navigationBarAppearnce.backgroundColor = UIColor.backgroundGray()
        navigationBarAppearnce.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationBarAppearnce.shadowImage = UIImage()
        navigationBarAppearnce.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.captionGray()]
    }

    private static func applyTableStyles() {
        UITableView.appearance().backgroundColor = UIColor.backgroundGray()
        UITableView.appearance().separatorColor = UIColor.clearColor()
        RealmCell.appearance().backgroundColor = UIColor.backgroundGray()
    }
}