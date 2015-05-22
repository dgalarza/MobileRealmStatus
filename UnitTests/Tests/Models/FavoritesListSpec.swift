import Quick
import Nimble

private let favoritesDefaultsKey = "favorites"

class FavoritesListSpec: QuickSpec {
    private var defaults: NSUserDefaults {
        get {
            return NSUserDefaults.standardUserDefaults()
        }
    }

    private var favorites: [String] {
        get {
            return defaults.objectForKey(favoritesDefaultsKey) as! [String]
        }
    }

    override func spec() {
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
                self.defaults.setObject(["Arthas"], forKey: favoritesDefaultsKey)
                self.defaults.synchronize()

                FavoritesList.sharedFavoritesList.removeFavorite("Arthas")

                expect(self.favorites).notTo(contain("Arthas"))
            }
        }
    }
}