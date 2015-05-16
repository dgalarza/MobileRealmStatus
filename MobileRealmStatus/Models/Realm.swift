import Foundation

class Realm {
    let name: String
    let type: String
    let status: Bool
    
    init(name: String, type: String, status: Bool) {
        self.name = name
        self.type = type
        self.status = status
    }
    
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