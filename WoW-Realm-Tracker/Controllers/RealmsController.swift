struct RealmsController {
    let realmsDelegate: RealmsDelegate
    let client = RealmsClient()

    func retrieveRealms() {
        client.realmStatus() { realms in
            self.realmsDelegate.receivedRealms(realms)
        }
    }
}
