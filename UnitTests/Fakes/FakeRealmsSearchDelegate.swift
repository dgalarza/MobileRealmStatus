class FakeRealmsSearchDelegate: RealmsSearchDelegate {
    var filteredRealms = [Realm]()

    func realmsFiltered(filteredRealms: [Realm]) {
        self.filteredRealms = filteredRealms
    }
}