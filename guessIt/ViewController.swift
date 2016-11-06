import Cocoa
import MultipeerConnectivity

class ViewController: NSViewController, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate {
    
    @IBOutlet private weak var leftImageView: NSImageView!
    @IBOutlet private weak var rightImageView: NSImageView!
    @IBOutlet private weak var randomWordField: NSTextField!
    
    private let wordBank = WordBank()
    private var peerIds = [MCPeerID]()
    private var advertiser: MCNearbyServiceAdvertiser!
    private var session: MCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetImages()
        let peerId = MCPeerID(displayName: "II-Host")
        session = MCSession(peer: peerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
        session!.delegate = self
        advertiser = MCNearbyServiceAdvertiser(peer: peerId, discoveryInfo: nil, serviceType: "II")
        advertiser.delegate = self
        advertiser.startAdvertisingPeer()
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        resetImages()
        let _ = try? session.send(wordBank.randomWords(), toPeers: peerIds, with: .reliable)
    }
    
    // MARK: - MCNearbyServiceAdvertiserDelegate
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        peerIds.append(peerID)
        invitationHandler(true, session)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let _ = try? self.session.send(self.wordBank.randomWords(), toPeers: self.peerIds, with: .reliable)
        }
    }
    
    // MARK: - MCSessionDelegate
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let selectedWord = NSKeyedUnarchiver.unarchiveObject(with: data) as? String {
            DispatchQueue.main.async {
                self.randomWordField.stringValue = selectedWord
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        
    }
    
    // MARK: - Private Helpers
    
    private func resetImages() {
        leftImageView.image = randomImage
        rightImageView.image = randomImage
    }
    
    private var randomImage: NSImage {
        let min = 1
        let max = 62
        let randomNumber = Int(arc4random_uniform(UInt32(max - min)) + UInt32(min))
        return NSImage(named: "\(randomNumber)")!
    }

}

