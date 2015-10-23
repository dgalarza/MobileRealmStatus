import Swish

struct RealmsController {
    let realmsDelegate: RealmsDelegate
    let client = APIClient()

    init(realmsDelegate: RealmsDelegate) {
        self.realmsDelegate = realmsDelegate
    }

    func retrieveRealms() {
        let request = RealmsRequest()
        client.performRequest(request, completionHandler: realmsDelegate.receivedRealms)
    }
}
