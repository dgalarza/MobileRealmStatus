struct RealmsController {
    let realmsDelegate: RealmsDelegate
    let apiClient = RealmsApi()

    func retrieveRealms() {
        apiClient.realmStatus() { realms in
            self.realmsDelegate.receivedRealms(realms)
        }
    }
}
