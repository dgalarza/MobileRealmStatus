import Result
import Argo
import Swish

struct RealmsRequest: Request {
    typealias ResponseType = [Realm]

    func build() -> NSURLRequest {
        let endpoint = "realm/status"
        return baseRequest(endpoint: endpoint)
    }

    func parse(j: JSON) -> Result<[Realm], NSError> {
        return .fromDecoded(j <|| "realms")
    }
}
