import UIKit

class RootViewController: UIViewController {
    var controller: RealmsController?

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.showWithMaskType(.Clear)
        controller?.retrieveRealms()
    }

    private func transitionToFavorites(realms: [Realm]) {
        let storyboard = UIStoryboard(name: "Main", bundle: .None)
        let nav = storyboard.instantiateInitialViewController() as! UINavigationController
        let vc = nav.topViewController as! FavoritesViewController
        vc.controller = FavoriteRealmsController(realms: realms)

        presentViewController(nav, animated: true, completion: nil)
    }
}

extension RootViewController: RealmsDelegate {
    func receivedRealms(realms: [Realm]) {
        transitionToFavorites(realms)
    }
}
