import UIKit

class RealmSearchController: NSObject, UISearchResultsUpdating {
    let realms: [Realm]
    let viewController: RealmsSearchDelegate

    init(realms: [Realm], viewController: RealmsSearchDelegate) {
        self.realms = realms
        self.viewController = viewController
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text
        let filteredRealms: [Realm]

        if searchTerm.isEmpty {
            filteredRealms = realms
        } else {
            filteredRealms = search(searchTerm)
        }

        viewController.realmsFiltered(filteredRealms)
    }

    func search(term: String) -> [Realm] {
        let predicate = NSPredicate(format: "self CONTAINS[c] %@", term)
        return realms.filter { predicate.evaluateWithObject($0.name) }
    }
}
