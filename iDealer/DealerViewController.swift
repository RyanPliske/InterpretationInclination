import UIKit

class DealerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DealerDelegate {
    
    @IBOutlet fileprivate weak var wordsTableView: UITableView!
    
    var model: ConnectionHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
        model.typeSelected(type: .dealer)
    }
    
    // MARK: - WordsHandlerDelegate
    
    func refreshDealerWords() {
        wordsTableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.wordSelected(atRow: indexPath.row)
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
}

