import UIKit
import Foundation

class FavoritesList: FavoritesManager {
    static let sharedFavoritesList = FavoritesList()

    private(set) var favorites: Set<String>

    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let favoritesArray = defaults.arrayForKey("favorites") as? [String]
        favorites = Set(favoritesArray ?? [])
    }

    func addFavorite(realmName: String) {
        favorites.insert(realmName)
        saveFavorites()
    }

    func removeFavorite(realmName: String) {
        if let index = favorites.indexOf(realmName) {
            favorites.removeAtIndex(index)
            saveFavorites()
        }
    }
}

private extension FavoritesList {
    var favoritesArray: [String] {
        return Array(favorites)
    }

    func saveFavorites() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favoritesArray, forKey: "favorites")
        defaults.synchronize()
    }
}
