import UIKit

class RealmSearchController: NSObject {
    let realms: [Realm]
    let searchDelegate: RealmsSearchDelegate

    init(realms: [Realm], searchDelegate: RealmsSearchDelegate) {
        self.searchDelegate = searchDelegate
        self.realms = realms
    }

    private func filterRealms(term: String) -> [Realm] {
        let predicate = NSPredicate(format: "self CONTAINS[c] %@", term)
        return realms.filter { predicate.evaluateWithObject($0.name) }
    }
}

extension RealmSearchController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let term = searchController.searchBar.text
        let filteredRealms: [Realm]

        if term.isEmpty {
            filteredRealms = realms
        } else {
            filteredRealms = filterRealms(term)
        }

        searchDelegate.realmsFiltered(filteredRealms)
    }
}