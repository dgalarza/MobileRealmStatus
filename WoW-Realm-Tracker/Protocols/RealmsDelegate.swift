import Result

public protocol RealmsDelegate {
    func receivedRealms(response: Result<[Realm], NSError>)
}
