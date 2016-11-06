import Foundation
import UIKit

class PlayerViewController: UIViewController, PlayerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var chooseColorButton: UIButton!
    
    var model: ConnectionHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        setup(control: nameTextField)
        setup(control: chooseColorButton)
        model.typeSelected(type: .player)
    }
    
    private func setup(control: UIControl) {
        control.layer.borderColor = UIColor.darkGray.cgColor
        control.layer.borderWidth = 1
        control.layer.cornerRadius = 5
    }
    
    @IBAction func colorButtonPressed(_ sender: Any) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.pinLeadingTrailingBottom(to: self.view, withHeightRatio: 0.333)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            model.nameUpdated(name: text)
        }
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        model.colorChosen(atIndex: row)
        chooseColorButton.backgroundColor = model.colors[row].type
        if let pickerView = self.view.subviews.filter({ $0 is UIPickerView }).first {
            pickerView.removeFromSuperview()
        }
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.colors[row].name
    }
    
}
