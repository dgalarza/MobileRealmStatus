import Result

protocol RealmsDelegate {
    func receivedRealms(response: Result<[Realm], NSError>)
}
