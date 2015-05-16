import UIKit

class FavoritesList {
    class var sharedFavoritesList : FavoritesList {
        struct Singleton {
            static let instance = FavoritesList()
        }

        return Singleton.instance
    }

    private(set) var favorites: [String]

    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedFavorites = defaults.objectForKey("favorites") as? [String]

        if storedFavorites != nil {
            favorites = storedFavorites!
        } else {
            favorites = []
        }
    }

    func addFavorite(realmName: String) {
        favorites.append(realmName)
        saveFavorites()
    }

    func removeFavorite(realmName: String) {
        if let index = find(favorites, realmName) {
            favorites.removeAtIndex(index)
            saveFavorites()
        }
    }

    private func saveFavorites() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favorites, forKey: "favorites")
        defaults.synchronize()
    }
}