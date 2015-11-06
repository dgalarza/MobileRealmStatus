protocol FavoritesManager {
    var favorites: Set<String> { get }
    var favoritesCount: Int { get }

    func addFavorite(realmName: String)
    func removeFavorite(realmName: String)
    func isFavorited(realmName: String) -> Bool
}

extension FavoritesManager {
    var favoritesCount: Int {
        return favorites.count
    }

    func isFavorited(realmName: String) -> Bool {
        return favorites.contains(realmName)
    }
}
