import Swish

public struct RealmsController {
    let realmsDelegate: RealmsDelegate
    let client = APIClient()

    public init(realmsDelegate: RealmsDelegate) {
        self.realmsDelegate = realmsDelegate
    }

    public func retrieveRealms() {
        let request = RealmsRequest()
        client.performRequest(request, completionHandler: realmsDelegate.receivedRealms)
    }
}
