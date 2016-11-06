import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MCBrowserViewControllerDelegate, WordsHandlerDelegate {
    
    @IBOutlet private weak var wordsTableView: UITableView!
    
    private let model = WordsHandler()
    private var browser: MCNearbyServiceBrowser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
        model.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if browser == nil {
            browser = MCNearbyServiceBrowser(peer: model.peerId, serviceType: "II")
            let browserVC = MCBrowserViewController(browser: browser!, session: model.session)
            browserVC.delegate = self
            self.present(browserVC, animated: true) {
                self.browser!.startBrowsingForPeers()
            }
        }
    }
    
    // MARK: - WordsHandlerDelegate
    
    func dataRefreshed() {
        wordsTableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.wordSelectedAtRow(row: indexPath.row)
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
        self.dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

