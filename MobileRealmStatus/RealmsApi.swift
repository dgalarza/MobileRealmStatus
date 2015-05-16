import Foundation

let requestUrl = "http://us.battle.net/api/wow/realm/status"

struct RealmsApi {
    func realmStatus(callback: ([Realm]) -> Void) {
        if let url = NSURL(string: requestUrl) {
            let request = NSURLRequest(URL: url)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
                self.parseJson(data, callback: callback)
            }
            
            task.resume()
        }
    }

    private func parseJson(data: NSData, callback: [Realm] -> ()) {
        let jsonOptional: AnyObject? = NSJSONSerialization.JSONObjectWithData(
            data,
            options: NSJSONReadingOptions(0),
            error: nil
        )
        
        if let json = jsonOptional as? [String: [[String: AnyObject]]] {
            if let realmsJson = json["realms"] {
                var realms = [Realm]()
                for realmJson in realmsJson {
                    if let realm = self.parseRealm(realmJson) {
                        realms.append(realm)
                    }
                }

                dispatch_async(dispatch_get_main_queue()) { callback(realms) }
            }
        }
    }
    
    private func parseRealm(realmJson: [String: AnyObject]) -> Realm? {
        if let name = realmJson["name"] as? String {
            if let type = realmJson["type"] as? String {
                if let status = realmJson["status"] as? Bool {
                    return Realm(name: name, type: type, status: status)
                }
            }
        }
        
        return nil
    }
}