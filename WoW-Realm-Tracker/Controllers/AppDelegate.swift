import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var controller = ApplicationController()
    lazy var window: UIWindow? = {
        return UIWindow.ApplicationWindow
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        AppearanceManager.applyCustomAppearance()
        window?.rootViewController = controller.rootViewController
        return true
    }
}
