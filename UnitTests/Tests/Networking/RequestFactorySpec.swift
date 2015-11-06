@testable import WoW_Realm_Tracker
import Nimble
import Quick

class RequestFactorySpec: QuickSpec {
    override func spec() {
        describe("baseRequest") {
            it("builds a request which includes the given api key") {
                let request = baseRequest(endpoint: "realms/status/", apiKey: "123")

                expect(request).to(includeQueryString("apikey=123"))
            }
        }
    }
}
