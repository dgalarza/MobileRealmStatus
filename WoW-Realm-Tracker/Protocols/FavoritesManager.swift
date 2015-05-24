protocol FavoritesManager {
    var favorites: [String] { get }

    func addFavorite(realmName: String)
    func removeFavorite(realmName: String)
}
