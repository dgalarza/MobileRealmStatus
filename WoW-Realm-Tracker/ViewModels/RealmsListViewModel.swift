import Foundation

class RealmsListViewModel {
    private let favoritesManager: FavoritesManager
    private let realms: [Realm]

    var count: Int {
        return realms.count
    }

    var favoritesCount: Int {
        return favoritesManager.favoritesCount
    }

    var hasFavorites: Bool {
        return !favoritesManager.favorites.isEmpty
    }

    init(realms: [Realm], favoritesManager: FavoritesManager = FavoritesList.sharedFavoritesList) {
        self.realms = realms
        self.favoritesManager = favoritesManager
    }

    func viewModelForCellAtIndexPath(indexPath: NSIndexPath) -> RealmViewModel {
        let realm = realms[indexPath.row]
        let isFavorited = favoriteRealms.contains(realm)
        return RealmViewModel(realm: realm, isFavorited: isFavorited)
    }

    func favoritedViewModelForCellAtIndexPath(indexPath: NSIndexPath) -> RealmViewModel {
        let realm = favoriteRealms[indexPath.row]
        return RealmViewModel(realm: realm, isFavorited: true)
    }

    func toggleFavoriteForRealmAtIndexPath(indexPath: NSIndexPath) {
        let realm = realms[indexPath.row]
        let realmName = realm.name

        if favoritesManager.isFavorited(realmName) {
            favoritesManager.removeFavorite(realmName)
        } else {
            favoritesManager.addFavorite(realmName)
        }
    }

    func removeFavoritedRealmAtIndexPath(indexPath: NSIndexPath) {
        let realm = favoriteRealms[indexPath.row]
        favoritesManager.removeFavorite(realm.name)
    }

    func filter(term: String) -> RealmsListViewModel {
        let predicate = NSPredicate(format: "self CONTAINS[c] %@", term)
        let filteredRealms = realms.filter { realm in predicate.evaluateWithObject(realm.name) }

        return RealmsListViewModel(realms: filteredRealms, favoritesManager: favoritesManager)
    }
}

private extension RealmsListViewModel {
    private var favoriteRealms: [Realm] {
        return realms.filter { favoritesManager.isFavorited($0.name) }
    }
}
