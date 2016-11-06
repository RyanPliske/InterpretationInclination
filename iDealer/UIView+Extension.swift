import UIKit

extension UIView {
    func pinLeadingTrailingBottom(to superView:UIView, withHeightRatio ratio:CGFloat) {
        superView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: ratio, constant: 0.0).isActive = true
    }
}
