import Quick
import Nimble

private let favoritesDefaultsKey = "favorites"

class FavoriteRealmsControllerSpec: QuickSpec {
    override func spec() {
        describe("addFavorite") {
            it("adds the realm to the user's favorites") {
                let realm = self.buildRealm("Arthas")
                let favoritesManager = FakeFavoritesManager()
                let favoriteRealmsController = FavoriteRealmsController(
                    realms: [realm],
                    favoritesManager: favoritesManager
                )

                favoriteRealmsController.addFavorite(realm)

                expect(favoritesManager.favorites).to(contain("Arthas"))
            }
        }

        describe("removeFavorite") {
            it("removes the given realm from the user's favorites") {
                let realm = self.buildRealm("Arthas")
                let favoritesManager = FakeFavoritesManager()
                favoritesManager.addFavorite("Arthas")

                let favoriteRealmsController = FavoriteRealmsController(
                    realms: [realm],
                    favoritesManager: favoritesManager
                )

                favoriteRealmsController.unfavorite(realm)

                expect(favoritesManager.favorites).notTo(contain("Arthas"))
            }
        }

        describe("realmIsFavorited") {
            context("user has favorited the realm") {
                it("returns true") {
                    let realm = self.buildRealm("Arthas")
                    let favoritesManager = FakeFavoritesManager()
                    let favoriteRealmsController = FavoriteRealmsController(
                        realms: [realm],
                        favoritesManager: favoritesManager
                    )
                    favoritesManager.addFavorite("Arthas")

                    expect(favoriteRealmsController.realmIsFavorited(realm)).to(beTrue())
                }
            }

            context("user has not favorited the realm") {
                it("returns false") {
                    let realm = self.buildRealm("Arthas")
                    let favoritesManager = FakeFavoritesManager()
                    let favoriteRealmsController = FavoriteRealmsController(
                        realms: [realm],
                        favoritesManager: favoritesManager
                    )

                    expect(favoriteRealmsController.realmIsFavorited(realm)).to(beFalse())
                }
            }
        }
    }

    private func buildRealm(name: String) -> Realm {
        return Realm(name: name, type: "pvp", status: true)
    }
}