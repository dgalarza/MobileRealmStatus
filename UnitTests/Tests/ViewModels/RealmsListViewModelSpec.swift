@testable import WoW_Realm_Tracker
import Nimble
import Quick

class RealmsListViewModelSpec: QuickSpec {
    override func spec() {
        describe("count") {
            it("returns the number of realms that are in the list") {
                let realms = buildRealmList("Arthas", "Skullcrusher")
                let viewModel = RealmsListViewModel(realms: realms)

                expect(viewModel.count).to(equal(2))
            }
        }

        describe("favoritesCount") {
            it("returns the number of favorited realms") {
                let realms = buildRealmList("Arthas", "Skullcrusher")
                let favoritesManager = favoritesManagerWithFavorites(realms[0])
                let viewModel = RealmsListViewModel(realms: realms, favoritesManager: favoritesManager)

                expect(viewModel.favoritesCount).to(equal(1))
            }
        }

        describe("hasFavorites") {
            it("returns true when the user has favorited some realms") {
                let realms = buildRealmList("Arthas")
                let favoritesManager = favoritesManagerWithFavorites(realms[0])
                let viewModel = RealmsListViewModel(realms: realms, favoritesManager: favoritesManager)

                expect(viewModel.hasFavorites).to(beTrue())
            }

            it("returns false when the user has not favorited any realms") {
                let favoritesManager = favoritesManagerWithFavorites()
                let viewModel = RealmsListViewModel(realms: [], favoritesManager: favoritesManager)

                expect(viewModel.hasFavorites).to(beFalse())
            }
        }

        describe("viewModelForCellAtIndexPath") {
            it("returns the appropriate realm") {
                let indexPath = NSIndexPath(forItem: 1, inSection: 0)
                let realms = buildRealmList("Arthas", "Skullcrusher")
                let favoritesManager = FakeFavoritesManager()
                let viewModel = RealmsListViewModel(realms: realms, favoritesManager: favoritesManager)

                let realm = viewModel.viewModelForCellAtIndexPath(indexPath)

                expect(realm.name).to(equal("Skullcrusher"))
                expect(realm.isFavorited).to(beFalse())
            }

            it("identifies favorited realms") {
                let indexPath = NSIndexPath(forItem: 0, inSection: 0)
                let realms = buildRealmList("Arthas")
                let favoritesManager = favoritesManagerWithFavorites(realms)
                let viewModel = RealmsListViewModel(realms: realms, favoritesManager: favoritesManager)

                let realm = viewModel.viewModelForCellAtIndexPath(indexPath)

                expect(realm.name).to(equal("Arthas"))
                expect(realm.isFavorited).to(beTrue())
            }
        }

        describe("favoritedViewModelForCellAtIndexPath") {
            it("returns the appropriate realm") {
                let indexPath = NSIndexPath(forItem: 1, inSection: 0)
                let realms = buildRealmList("Arthas", "Skullcrusher")
                let favoritesManager = favoritesManagerWithFavorites(realms)
                let viewModel = RealmsListViewModel(realms: realms, favoritesManager: favoritesManager)

                let realm = viewModel.favoritedViewModelForCellAtIndexPath(indexPath)

                expect(realm.name).to(equal("Skullcrusher"))
            }
        }

        describe("toggleFavoriteForRealmAtIndexPath") {
            it("adds the realm to the user's favorites if it is not already favorited") {
                let indexPath = NSIndexPath(forItem: 1, inSection: 0)
                let realms = buildRealmList("Arthas", "Skullcrusher")
                let favoritesManager = FakeFavoritesManager()
                let viewModel = RealmsListViewModel(realms: realms, favoritesManager: favoritesManager)

                viewModel.toggleFavoriteForRealmAtIndexPath(indexPath)

                expect(favoritesManager.isFavorited("Skullcrusher")).to(beTrue())
            }

            it("removes an already favorited realm") {
                let indexPath = NSIndexPath(forItem: 0, inSection: 0)
                let realms = buildRealmList("Arthas")
                let favoritesManager = FakeFavoritesManager()
                favoritesManager.addFavorite("Arthas")
                let viewModel = RealmsListViewModel(realms: realms, favoritesManager: favoritesManager)

                viewModel.toggleFavoriteForRealmAtIndexPath(indexPath)

                expect(favoritesManager.isFavorited("Arthas")).to(beFalse())
            }
        }

        describe("removeFavoritedRealmAtIndexPath") {
            it("removes the given realm from the user's favorites") {
                let indexPath = NSIndexPath(forItem: 0, inSection: 0)
                let realms = buildRealmList("Arthas")
                let favoritesManager = favoritesManagerWithFavorites(realms)
                let viewModel = RealmsListViewModel(realms: realms, favoritesManager: favoritesManager)

                viewModel.removeFavoritedRealmAtIndexPath(indexPath)

                expect(favoritesManager.isFavorited("Arthas")).to(beFalse())
            }
        }
    }
}

private func favoritesManagerWithFavorites(favorites: Realm...) -> FavoritesManager {
    return favoritesManagerWithFavorites(favorites)
}

private func favoritesManagerWithFavorites(favorites: [Realm]) -> FavoritesManager {
    let favoritesManager = FakeFavoritesManager()

    for favorite in favorites {
        favoritesManager.addFavorite(favorite.name)
    }

    return favoritesManager
}

func buildRealmList(names: String...) -> [Realm] {
    return names.map { Realm(name: $0, type: .PvP, status: true) }
}
