import RealmTracker
import Quick
import Nimble

class RealmViewModelSpec: QuickSpec {
    override func spec() {
        describe("name") {
            it("returns the realm's name") {
                let realm = Realm(name: "Arthas", type: "pvp", status: true)
                let viewModel = RealmViewModel(realm: realm, favoritesController: FavoriteRealmsController(realms: []))

                expect(viewModel.name).to(equal("Arthas"))
            }
        }

        describe("favoritedImage") {
            context("user has favorited realm") {
                it("returns the 'Favorited' image name") {
                    let realm = Realm(name: "Arthas", type: "pvp", status: true)
                    let favoritesManager = FakeFavoritesManager()
                    let favoritesController = FavoriteRealmsController(realms: [], favoritesManager: favoritesManager)
                    let viewModel = RealmViewModel(realm: realm, favoritesController: favoritesController)

                    favoritesManager.addFavorite("Arthas")

                    expect(viewModel.favoritedImage).to(equal("Favorited"))
                }
            }

            context("user has not favorited the realm") {
                it("returns the 'Favorite' image name") {
                    let realm = Realm(name: "Arthas", type: "pvp", status: true)
                    let favoritesManager = FakeFavoritesManager()
                    let favoritesController = FavoriteRealmsController(realms: [], favoritesManager: favoritesManager)
                    let viewModel = RealmViewModel(realm: realm, favoritesController: favoritesController)

                    expect(viewModel.favoritedImage).to(equal("Favorite"))
                }
            }
        }

        describe("availabilityImage") {
            context("realm is available") {
                it("returns the available image name") {
                    let realm = Realm(name: "Arthas", type: "pvp", status: true)
                    let favoritesController = FavoriteRealmsController(realms: [])
                    let viewModel = RealmViewModel(realm: realm, favoritesController: favoritesController)

                    expect(viewModel.availabilityImage).to(equal("Available"))
                }
            }

            context("realm is unavailable") {
                it("returns the 'unavailable' image") {
                    let realm = Realm(name: "Arthas", type: "pvp", status: false)
                    let favoritesController = FavoriteRealmsController(realms: [])
                    let viewModel = RealmViewModel(realm: realm, favoritesController: favoritesController)

                    expect(viewModel.availabilityImage).to(equal("Unavailable"))
                }
            }
        }
    }
}
