import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MCBrowserViewControllerDelegate {
    
    @IBOutlet weak var wordsTableView: UITableView!
    
    private let model = WordsHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let browser = MCNearbyServiceBrowser(peer: model.peerId, serviceType: "II")
        let browserVC = MCBrowserViewController(browser: browser, session: model.session)
        browserVC.delegate = self
        self.present(browserVC, animated: true) {
            browser.startBrowsingForPeers()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! WordCell
        cell.wordLabel.text = model.words[indexPath.row]
        return cell
    }
    
    // MARK: - MCBrowserViewControllerDelegate
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        
    }
}

