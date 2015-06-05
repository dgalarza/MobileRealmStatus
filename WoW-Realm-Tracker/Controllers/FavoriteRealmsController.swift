struct FavoriteRealmsController {
    private let favoritesManager: FavoritesManager
    let realms: [Realm]

    init(realms: [Realm], favoritesManager: FavoritesManager? = nil) {
        self.realms = realms
        self.favoritesManager = favoritesManager.map { $0 } ?? FavoritesList.sharedFavoritesList
    }

    var favoriteRealms: [Realm] {
        get {
            return realms.filter { contains(self.favoritesManager.favorites, $0.name) }
        }
    }

    func addFavorite(realm: Realm) {
        favoritesManager.addFavorite(realm.name)
    }

    func unfavorite(realm: Realm) {
        favoritesManager.removeFavorite(realm.name)
    }

    func shouldShowEmptyState() -> Bool {
        return favoritesManager.favorites.isEmpty
    }

    func realmIsFavorited(realm: Realm) -> Bool {
        return contains(favoritesManager.favorites, realm.name)
    }
}
