import Result
import Argo
import Swish

struct RealmsRequest: Request {
    typealias ResponseType = [Realm]

    let requestUrl = "http://us.battle.net/api/wow/realm/status"

    func build() -> NSURLRequest {
        let url = NSURL(string: requestUrl)!
        return NSURLRequest(URL: url)
    }

    func parse(j: JSON) -> Result<[Realm], NSError> {
        return .fromDecoded(j <|| "realms")
    }
}
