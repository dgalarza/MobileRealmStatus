@testable import WoW_Realm_Tracker

class FakeFavoritesManager: FavoritesManager {
    var favorites = [String]()

    func addFavorite(realmName: String) {
        favorites.append(realmName)
    }

    func  removeFavorite(realmName: String) {
        if let index = favorites.indexOf(realmName) {
            favorites.removeAtIndex(index)
        }
    }
}
