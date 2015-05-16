import Runes
import Argo

struct Realm {
    let name: String
    let type: String
    let status: Bool
    
    func displayStatus() -> String {
        if status {
            return "Available"
        } else {
            return "Unavailable"
        }
    }
    
    func displayType() -> String {
        if type == "pve" {
            return "PvE"
        } else {
            return "PvP"
        }
    }
}

extension Realm: Decodable {
    static func create(name:String)(type: String)(status: Bool) -> Realm {
        return Realm(name: name, type: type, status: status)
    }

    static func decode(j: JSON) -> Decoded<Realm> {
        return Realm.create
            <^> j <| "name"
            <*> j <| "type"
            <*> j <| "status"
    }
}
