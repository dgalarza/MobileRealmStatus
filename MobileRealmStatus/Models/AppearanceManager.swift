import UIKit

struct AppearanceManager {
    static func applyCustomAppearance() {
        applyNavBarStyles()
        applyTableStyles()
        applySearchStyles()
        applyButtonStyles()
    }

    static func customizeRealmCell(cell: RealmCell) {
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.textColor = UIColor.captionGray()
    }

    private static func applyNavBarStyles() {
        let navigationBarAppearnce = UINavigationBar.appearance()
        navigationBarAppearnce.barTintColor = UIColor.backgroundGray()
        navigationBarAppearnce.backgroundColor = UIColor.backgroundGray()
        navigationBarAppearnce.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationBarAppearnce.shadowImage = UIImage()

        navigationBarAppearnce.titleTextAttributes = [
            NSFontAttributeName: UIFont.headlineFont()!,
            NSForegroundColorAttributeName:UIColor.captionGray()
        ]
    }

    private static func applyTableStyles() {
        UITableView.appearance().backgroundColor = UIColor.backgroundGray()
        UITableView.appearance().separatorColor = UIColor.clearColor()
        RealmCell.appearance().backgroundColor = UIColor.backgroundGray()
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
}
