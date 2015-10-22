import UIKit
import Quick
import Nimble

class RealmSearchControllerSpec: QuickSpec {
    override func spec() {
        describe("search") {
            it("filters the given realms by the search term") {
                let realmA = Realm(name: "Arthas", type: .PvP, status: true)
                let realmB = Realm(name: "Skullcrusher", type: .PvP, status: true)
                let fakeRealmsSearchDelegate = FakeRealmsSearchDelegate()

                let searchController = RealmSearchController(realms: [realmB, realmA], viewController: fakeRealmsSearchDelegate)

                searchController.search("art")
                let filteredRealms = fakeRealmsSearchDelegate.filteredRealms.map { $0.name }

                expect(filteredRealms).to(contain("Arthas"))
                expect(filteredRealms).notTo(contain("Skullcrusher"))
            }
        }
    }
}