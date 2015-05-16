import Runes
import Argo

let requestUrl = "http://us.battle.net/api/wow/realm/status"

struct RealmsApi {
    func realmStatus(callback: ([Realm]) -> Void) {
        if let url = NSURL(string: requestUrl) {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
                self.parseJson(data, callback: callback)
            }
            
            task.resume()
        }
    }

    private func parseJson(data: NSData, callback: [Realm] -> ()) {
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)

        if let j: AnyObject = json {
            let realms: [Realm] = j["realms"] >>- decode ?? []
            dispatch_async(dispatch_get_main_queue()) { callback(realms) }
        }
    }
}