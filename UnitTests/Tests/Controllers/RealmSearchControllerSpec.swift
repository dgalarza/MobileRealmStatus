import UIKit
import Quick
import Nimble

class RealmSearchControllerSpec: QuickSpec {
    override func spec() {
        describe("search") {
            it("filters the given realms by the search term") {
                let realms = self.buildRealmsList("Arthas", "Skullcrusher")
                let fakeRealmsSearchDelegate = FakeRealmsSearchDelegate()
                let searchController = RealmSearchController(
                    realms: realms,
                    viewController: fakeRealmsSearchDelegate
                )

                searchController.search("art")
                let filteredRealms = fakeRealmsSearchDelegate.filteredRealms.map { $0.name }

                expect(filteredRealms).to(contain("Arthas"))
                expect(filteredRealms).notTo(contain("Skullcrusher"))
            }
        }

        describe("clear") {
            it("restores filtered realms to original data set") {
                let realms = self.buildRealmsList("Arthas", "Skullcrusher")
                let fakeRealmsSearchDelegate = FakeRealmsSearchDelegate()
                let searchController = RealmSearchController(
                    realms: realms,
                    viewController: fakeRealmsSearchDelegate
                )

                searchController.search("art")
                searchController.clear()
                let filteredRealms = fakeRealmsSearchDelegate.filteredRealms.map { $0.name }

                expect(filteredRealms).to(contain("Arthas"))
                expect(filteredRealms).to(contain("Skullcrusher"))
            }
        }
    }

    private func buildRealmsList(names: String...) -> [Realm] {
        return names.map { Realm(name: $0, type: "pvp", status: true) }
    }
}
