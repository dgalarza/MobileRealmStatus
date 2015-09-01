import RealmTracker

class FakeFavoritesManager: FavoritesManager {
    var favorites = [String]()

    func addFavorite(realmName: String) {
        favorites.append(realmName)
    }

    func  removeFavorite(realmName: String) {
        if let index = find(favorites, realmName) {
            favorites.removeAtIndex(index)
        }
    }
}
