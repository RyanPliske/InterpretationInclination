import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var leftImageView: NSImageView!
    @IBOutlet weak var rightImageView: NSImageView!
    @IBOutlet weak var randomWordField: NSTextField!
    
    let wordBank = WordBank()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetImages()
        resetWord()
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        resetImages()
        resetWord()
    }
    
    private func resetWord() {
        randomWordField.stringValue = wordBank.randomWord()
    }
    
    private func resetImages() {
        leftImageView.image = randomImage
        rightImageView.image = randomImage
    }
    
    private var randomImage: NSImage {
        let min = 1
        let max = 60
        let randomNumber = Int(arc4random_uniform(UInt32(max - min)) + UInt32(min))
        return NSImage(named: "\(randomNumber)")!
    }

}

