import Runes
import Argo

struct RealmsClient {
    let requestUrl = "http://us.battle.net/api/wow/realm/status"

    func realmStatus(callback: ([Realm]) -> Void) {
        let url = NSURL(string: requestUrl)
        let task = url.map { NSURLSession.sharedSession().dataTaskWithURL($0) { (data, response, error) in
                self.parseJson(data, callback: callback)
            }
        }

        task?.resume()
    }

    private func parseJson(data: NSData, callback: [Realm] -> ()) {
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)

        if let j: AnyObject = json {
            let realms: [Realm] = (j["realms"] >>- decode) ?? []
            dispatch_async(dispatch_get_main_queue()) { callback(realms) }
        }
    }
}
