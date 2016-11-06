import UIKit.UIView

open class KeyboardListeningView: UIView {
    
    public init() {
        super.init(frame: CGRect.zero)
        startObserving()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        startObserving()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startObserving()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // MARK - Private Helper Methods
    
    fileprivate func startObserving() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    @objc fileprivate func keyboardWillChangeFrame(_ sender: Notification) {
        self.keyboardFrameChange(withNotification: sender)
    }
    
    fileprivate func keyboardFrameChange(withNotification notification: Notification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            if let firstResponder = findFirstResponder() {
                animateIfNeeded(firstResponder, keyboardFrame: keyboardFrame)
            }
        }
    }
    
    fileprivate func findFirstResponder() -> UIView? {
        if self.isFirstResponder {
            return nil
        } else {
            let possibleFirstResponder = self.subviews.filter({ $0.isFirstResponder }).first
            return possibleFirstResponder
        }
    }
    
    fileprivate func animateIfNeeded(_ focusedView: UIView, keyboardFrame: CGRect) {
        let animateDuration:Double = 0.5
        
        if keyboardFrame.origin.y > self.frame.origin.y + self.frame.height {
            UIView.animate(withDuration: animateDuration, animations: { [weak self] in
                self?.frame.origin.y = 0
            })
        } else {
            let focusedFrame = self.convert(focusedView.bounds, from: focusedView)
            let padding: CGFloat = 20
            var shiftYPixels = (focusedFrame.origin.y + focusedFrame.size.height + padding) - keyboardFrame.origin.y
            
            if self.frame.origin.y >= 0  && shiftYPixels < 0 {
                shiftYPixels = 0
            } else if self.frame.origin.y < 0 {
                if shiftYPixels > 0 {
                    shiftYPixels = self.frame.origin.y + shiftYPixels
                } else {
                    shiftYPixels += self.frame.origin.y
                    if abs(shiftYPixels) > abs(self.frame.origin.y) {
                        shiftYPixels = self.frame.origin.y
                    }
                }
            }
            if shiftYPixels > keyboardFrame.height + self.frame.origin.y {
                shiftYPixels = keyboardFrame.height + self.frame.origin.y
            }
            UIView.animate(withDuration: animateDuration, animations: { [weak self] in
                self?.frame.origin.y -= shiftYPixels
            })
        }
    }
    
}
