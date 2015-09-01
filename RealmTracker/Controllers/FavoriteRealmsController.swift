import RealmTracker

public struct FavoriteRealmsController {
    private let favoritesManager: FavoritesManager
    public let realms: [Realm]

    public init(realms: [Realm], favoritesManager: FavoritesManager? = .None) {
        self.realms = realms
        self.favoritesManager = favoritesManager.map { $0 } ?? FavoritesList.sharedFavoritesList
    }

    public var favoriteRealms: [Realm] {
        get {
            return realms.filter { contains(self.favoritesManager.favorites, $0.name) }
        }
    }

    public func addFavorite(realm: Realm) {
        favoritesManager.addFavorite(realm.name)
    }

    public func unfavorite(realm: Realm) {
        favoritesManager.removeFavorite(realm.name)
    }

    public func shouldShowEmptyState() -> Bool {
        return favoritesManager.favorites.isEmpty
    }

    public func realmIsFavorited(realm: Realm) -> Bool {
        return contains(favoritesManager.favorites, realm.name)
    }
}
