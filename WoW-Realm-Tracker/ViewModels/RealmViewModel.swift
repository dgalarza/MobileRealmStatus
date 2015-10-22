struct RealmViewModel {
    let realm: Realm
    let favoritesController: FavoriteRealmsController

    var name: String {
        return realm.name
    }

    var favoritedImage: String {
        let image: String

        if isFavorited() {
            image = "Favorited"
        } else {
            image = "Favorite"
        }
        
        return image
    }

    var type: Realm.RealmType {
        return realm.type
    }

    var availabilityImage: String {
        let status: String

        if realm.status {
            status = "Available"
        } else {
            status = "Unavailable"
        }

        return status
    }

    private func isFavorited() -> Bool {
        return  favoritesController.realmIsFavorited(realm)
    }
}
