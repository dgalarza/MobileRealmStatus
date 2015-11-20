import UIKit
import Result
import Swish

class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRealms()
    }

    private func transitionToFavorites(realms: [Realm]) {
        let storyboard = UIStoryboard(name: "Main", bundle: .None)
        let nav = storyboard.instantiateInitialViewController() as! UINavigationController
        let vc = nav.topViewController as! FavoritesViewController
        vc.viewModel = RealmsListViewModel(realms: realms)

        presentViewController(nav, animated: true, completion: nil)
    }
}

private extension RootViewController {
    func fetchRealms() {
        SVProgressHUD.showWithMaskType(.Clear)

        let request = RealmsRequest()
        APIClient().performRequest(request, completionHandler: receivedRealms)
    }

    func receivedRealms(response: Result<[Realm], NSError>) {
        if let realms = response.value {
            transitionToFavorites(realms)
        }
    }
}
