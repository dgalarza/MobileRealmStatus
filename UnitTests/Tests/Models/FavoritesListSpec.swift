@testable import WoW_Realm_Tracker
import Nimble
import Quick

private let favoritesDefaultsKey = "favorites"

class FavoritesListSpec: QuickSpec {
    private var defaults: NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }

    private var favorites: [String] {
        return defaults.arrayForKey(favoritesDefaultsKey) as! [String]
    }

    override func spec() {
        beforeEach {
            self.defaults.setObject([], forKey: favoritesDefaultsKey)
            self.defaults.synchronize()
        }

        afterEach {
            self.defaults.setObject([], forKey: favoritesDefaultsKey)
            self.defaults.synchronize()
        }

        describe("addFavorite") {
            it("adds the given string to the favorites list") {
                FavoritesList.sharedFavoritesList.addFavorite("Arthas")

                expect(self.favorites).to(contain("Arthas"))
            }
        }

        describe("removeFavorite") {
            it("removes the given favorite from the favorites list") {
                let defaults = self.defaults
                defaults.setObject(["Arthas"], forKey: favoritesDefaultsKey)
                defaults.synchronize()

                FavoritesList.sharedFavoritesList.removeFavorite("Arthas")

                defaults.synchronize()
                let favorites = defaults.objectForKey(favoritesDefaultsKey) as! [String]
                expect(favorites).notTo(contain("Arthas"))
            }
        }

        describe("isFavorited") {
            it("returns true when the given realm is favorited") {
                FavoritesList.sharedFavoritesList.addFavorite("Arthas")

                let isFavorited = FavoritesList.sharedFavoritesList.isFavorited("Arthas")

                expect(isFavorited).to(beTrue())
            }

            it("returns false when the given realm is not favorited") {
                let isFavorited = FavoritesList.sharedFavoritesList.isFavorited("Other")

                expect(isFavorited).to(beFalse())
            }
        }

        describe("favoritesCount") {
            it("returns the number of favorited realms") {
                FavoritesList.sharedFavoritesList.addFavorite("Arthas")
                FavoritesList.sharedFavoritesList.addFavorite("Skullcrusher")

                let favoritesCount = FavoritesList.sharedFavoritesList.favoritesCount

                expect(favoritesCount).to(equal(2))
            }
        }
    }
}
