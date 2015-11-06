import Runes
import Argo
import Curry

struct Realm {
    enum RealmType: String, CustomStringConvertible {
        case PvP = "pvp"
        case PvE = "pve"
        case RP = "rp"
        case RPPvP = "rppvp"

        var description: String {
            switch self {
            case .PvP: return "PvP"
            case .PvE: return "PvE"
            case .RP: return "RP"
            case .RPPvP: return "RP PvP"
            }
        }
    }

    let name: String
    let type: RealmType
    let status: Bool
}

extension Realm: Decodable {
    static func decode(j: JSON) -> Decoded<Realm> {
        return curry(Realm.init)
            <^> j <| "name"
            <*> j <| "type"
            <*> j <| "status"
    }
}

extension Realm.RealmType: Decodable { }

extension Realm: Equatable {}
func == (lhs: Realm, rhs: Realm) -> Bool {
    return lhs.name == rhs.name
}

extension Realm: Hashable {
    var hashValue: Int {
        return name.hashValue
    }
}
