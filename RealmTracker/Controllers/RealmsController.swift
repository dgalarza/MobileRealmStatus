public struct RealmsController {
    let realmsDelegate: RealmsDelegate
    let client = RealmsClient()

    public init(realmsDelegate: RealmsDelegate) {
        self.realmsDelegate = realmsDelegate
    }

    public func retrieveRealms() {
        client.realmStatus() { realms in
            self.realmsDelegate.receivedRealms(realms)
        }
    }
}
