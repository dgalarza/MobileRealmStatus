import Foundation

struct RealmSearchController {
    let realms: [Realm]
    let viewController: RealmsSearchDelegate

    func search(searchTerm: String) {
        let filteredRealms: [Realm]

        if searchTerm.isEmpty {
            filteredRealms = realms
        } else {
            filteredRealms = filterRealms(searchTerm)
        }

        viewController.realmsFiltered(filteredRealms)
    }

    func clear() {
        viewController.realmsFiltered(realms)
    }

    private func filterRealms(term: String) -> [Realm] {
        let predicate = NSPredicate(format: "self CONTAINS[c] %@", term)
        return realms.filter { predicate.evaluateWithObject($0.name) }
    }
}
