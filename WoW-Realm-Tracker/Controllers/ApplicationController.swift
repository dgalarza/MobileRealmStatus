import RealmTracker

struct ApplicationController {
    var rootViewController: UIViewController {
        let vc = RootViewController()
        vc.controller = RealmsController(realmsDelegate: vc)
        return vc
    }
}
