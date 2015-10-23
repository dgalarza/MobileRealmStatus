import Runes
import Argo

struct Realm {
    let name: String
    let type: String
    let status: Bool

    init(name: String, type: String, status: Bool) {
        self.name = name
        self.type = type
        self.status = status
    }
}

extension Realm: Decodable {
    static func create(name:String)(type: String)(status: Bool) -> Realm {
        return Realm(name: name, type: type, status: status)
    }

    static func decode(j: JSON) -> Decoded<Realm> {
        return create
            <^> j <| "name"
            <*> j <| "type"
            <*> j <| "status"
    }
}
