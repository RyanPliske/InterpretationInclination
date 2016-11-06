import Foundation
import MultipeerConnectivity

#if os(OSX)
    import AppKit
    typealias ColorType = NSColor
#elseif os(iOS)
    import UIKit
    typealias ColorType = UIColor
#endif

enum PlayerType: String {
    case dealer
    case player
}

class Player: Equatable {
    var id: MCPeerID
    var color: ColorType?
    var name: String?
    var type: PlayerType?
    
    init(id: MCPeerID) {
        self.id = id
    }
    
    func toDictionary() -> NSDictionary {
        var dict: [String: Any] = [
            "id" : id,
        ]
        if let color = color {
            dict["color"] = color
        }
        if let name = name {
            dict["name"] = name
        }
        if let type = type {
            dict["type"] = type.rawValue
        }
        return dict as NSDictionary
    }
    
    class func from(dictionary dict: NSDictionary) -> Player {
        let id = dict["id"] as! MCPeerID
        let player = Player(id: id)
        if let color = dict["color"] as? ColorType {
            player.color = color
        }
        if let name = dict["name"] as? String {
            player.name = name
        }
        if let type = dict["type"] as? String {
            player.type = PlayerType(rawValue: type)
        }
        return player
    }
}

func == (lhs: Player, rhs: Player) -> Bool {
    return lhs.id == rhs.id
}
