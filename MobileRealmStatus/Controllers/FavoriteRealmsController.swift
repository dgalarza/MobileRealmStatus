struct FavoriteRealmsController {
    private let favoritesList: FavoritesList
    let realms: [Realm]

    init(realms: [Realm]) {
        self.realms = realms
        favoritesList = FavoritesList.sharedFavoritesList
    }

    var favoriteRealms: [Realm] {
        get {
            return realms.filter { contains(self.favoritesList.favorites, $0.name) }
        }
    }

    func addFavorite(realm: Realm) {
        favoritesList.addFavorite(realm.name)
    }

    func unfavorite(realm: Realm) {
        favoritesList.removeFavorite(realm.name)
    }

    func realmIsFavorited(realm: Realm) -> Bool {
        return contains(favoritesList.favorites, realm.name)
    }
}
