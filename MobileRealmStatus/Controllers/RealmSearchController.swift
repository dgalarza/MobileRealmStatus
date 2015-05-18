import Foundation

struct RealmSearchController {
    let realms: [Realm]
    let searchDelegate: RealmsSearchDelegate

    func search(term: String) {
        let predicate = NSPredicate(format: "self CONTAINS[c] %@", term)
        let filteredRealms = realms.filter { predicate.evaluateWithObject($0.name) }
        searchDelegate.realmsFiltered(filteredRealms)
    }
}
