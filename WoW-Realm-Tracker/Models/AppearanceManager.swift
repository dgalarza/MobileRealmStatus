import UIKit

struct AppearanceManager {
    static func applyCustomAppearance() {
        applyNavBarStyles()
        applyTableStyles()
        applySearchStyles()
        applyButtonStyles()
        applySVProgressHUDStyles()
    }

    static func customizeRealmCell(cell: RealmCell) {
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.textColor = UIColor.captionGray()
    }

    private static func applyNavBarStyles() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = UIColor.backgroundGray()
        navigationBarAppearance.backgroundColor = UIColor.backgroundGray()
        navigationBarAppearance.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationBarAppearance.shadowImage = UIImage()

        navigationBarAppearance.titleTextAttributes = [
            NSFontAttributeName: UIFont.headlineFont()!,
            NSForegroundColorAttributeName:UIColor.captionGray()
        ]
    }

    private static func applyTableStyles() {
        UITableView.appearance().backgroundColor = UIColor.backgroundGray()
        UITableView.appearance().separatorColor = UIColor.clearColor()

        RealmCell.appearance().selectionStyle = .None
        RealmCell.appearance().backgroundColor = UIColor.backgroundGray()
        RealmCell.appearance().tintColor = UIColor.clearColor()
    }

    private static func applySearchStyles() {
        UISearchBar.appearance().backgroundColor = UIColor.backgroundGray()
        UISearchBar.appearance().barTintColor = UIColor.backgroundGray()
        UISearchBar.appearance().setBackgroundImage(UIImage(), forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
    }

    private static func applyButtonStyles() {
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSFontAttributeName: UIFont.bodyFont()!],
            forState: UIControlState.Normal
        )
    }

    private static func applySVProgressHUDStyles() {
        SVProgressHUD.setBackgroundColor(UIColor.clearColor())
        SVProgressHUD.setForegroundColor(UIColor.captionGray())
    }
}
