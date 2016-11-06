import Foundation
import UIKit
import MultipeerConnectivity

class SelectionViewController: UIViewController, MCBrowserViewControllerDelegate {

    fileprivate let model = ConnectionHandler()
    fileprivate var browser: MCNearbyServiceBrowser?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if browser == nil {
            browser = MCNearbyServiceBrowser(peer: model.player.id, serviceType: "II")
            let browserVC = MCBrowserViewController(browser: browser!, session: model.session)
            browserVC.delegate = self
            self.present(browserVC, animated: true) {
                self.browser!.startBrowsingForPeers()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dealerVC = segue.destination as? DealerViewController {
            dealerVC.model = model
            dealerVC.model.dealerDelegate = dealerVC
        } else if let playerVC = segue.destination as? PlayerViewController {
            playerVC.model = model
            playerVC.model.playerDelegate = playerVC
        }
    }
    
    // MARK: - MCBrowserViewControllerDelegate
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
