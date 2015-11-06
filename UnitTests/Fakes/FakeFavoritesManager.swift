@testable import WoW_Realm_Tracker

class FakeFavoritesManager: FavoritesManager {
    var favorites = Set<String>()

    func addFavorite(realmName: String) {
        favorites.insert(realmName)
    }

    func removeFavorite(realmName: String) {
        if let index = favorites.indexOf(realmName) {
            favorites.removeAtIndex(index)
        }
    }
}
