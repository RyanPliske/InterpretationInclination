import Foundation
import MultipeerConnectivity

protocol WordsHandlerDelegate: class {
    func dataRefreshed()
}

class WordsHandler: NSObject, MCSessionDelegate {
    
    let peerId: MCPeerID
    let session: MCSession
    var words = [String]()
    var delegate: WordsHandlerDelegate?
    var hostPeerId: MCPeerID?
    
    override init() {
        peerId = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
        super.init()
        session.delegate = self
    }
    
    func worSelectedAtRow(row: Int) {
        if let hostPeerId = hostPeerId {
            let wordToSend = NSKeyedArchiver.archivedData(withRootObject: words[row])
            let _ = try? session.send(wordToSend, toPeers: [hostPeerId], with: .reliable)
        }
    }
    
    // MARK: - MCSessionDelegate
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let words = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] {
            self.words = words
            self.delegate?.dataRefreshed()
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        
    }
    
}
