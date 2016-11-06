import Foundation
import MultipeerConnectivity

protocol DealerDelegate: class {
    func refreshDealerWords()
}

protocol PlayerDelegate: class {
    
}

struct Color {
    var type: ColorType
    var name: String
}

class ConnectionHandler: NSObject, MCSessionDelegate {
    
    var player: Player
    let session: MCSession
    let colors: [Color]
    var words = [String]()
    weak var dealerDelegate: DealerDelegate?
    weak var playerDelegate: PlayerDelegate?
    
    override init() {
        let peerId = MCPeerID(displayName: UIDevice.current.name)
        player = Player(id: peerId)
        session = MCSession(peer: peerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
        colors = [Color(type: ColorType.magenta, name: "Pink"),
                  Color(type: ColorType.purple, name: "Purple"),
                  Color(type: ColorType.green, name: "Green"),
                  Color(type: ColorType.blue, name: "Blue"),
                  Color(type: ColorType.cyan, name: "Cyan"),
                  Color(type: ColorType.yellow, name: "Yellow")]
        super.init()
        session.delegate = self
    }
    
    func wordSelected(atRow row: Int) {
        if let hostPeerId = hostPeerId {
            let wordToSend = NSKeyedArchiver.archivedData(withRootObject: words[row])
            let _ = try? session.send(wordToSend, toPeers: [hostPeerId], with: .reliable)
        }
    }
    
    private func playerUpdated() {
        if let hostPeerId = hostPeerId {
            let playerToSend = NSKeyedArchiver.archivedData(withRootObject: player.toDictionary())
            let _ = try? session.send(playerToSend, toPeers: [hostPeerId], with: .reliable)
        }
    }
    
    private var hostPeerId: MCPeerID? {
        return self.session.connectedPeers.filter({ $0.displayName == "II-Host" }).first
    }
    
    func typeSelected(type: PlayerType) {
        player.type = type
        playerUpdated()
    }
    
    func nameUpdated(name: String) {
        player.name = name
        playerUpdated()
    }
    
    func colorChosen(atIndex index: Int) {
        player.color = colors[index].type
        playerUpdated()
    }
    
    // MARK: - MCSessionDelegate
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let words = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] {
            self.words = words
            DispatchQueue.main.async {
                self.dealerDelegate?.refreshDealerWords()
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        
    }
    
}
