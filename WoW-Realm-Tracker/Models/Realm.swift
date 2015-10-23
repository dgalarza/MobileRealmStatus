import Argo

public struct Realm {
    public let name: String
    public let type: String
    public let status: Bool

    public init(name: String, type: String, status: Bool) {
        self.name = name
        self.type = type
        self.status = status
    }
}

extension Realm: Decodable {
    static func create(name:String)(type: String)(status: Bool) -> Realm {
        return Realm(name: name, type: type, status: status)
    }

    public static func decode(j: JSON) -> Decoded<Realm> {
        return create
            <^> j <| "name"
            <*> j <| "type"
            <*> j <| "status"
    }
}
