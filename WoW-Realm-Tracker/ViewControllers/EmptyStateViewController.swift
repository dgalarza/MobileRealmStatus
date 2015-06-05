import UIKit

class EmptyStateViewController: UIViewController {
    static func create() -> EmptyStateViewController {
        return EmptyStateViewController(nibName: "EmptyState", bundle: .None)
    }
}
