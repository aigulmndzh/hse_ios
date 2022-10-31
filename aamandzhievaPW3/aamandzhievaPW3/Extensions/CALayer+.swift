import UIKit

extension CALayer {
    func applyShadow() {
        self.shadowRadius = 20
        self.shadowOffset = CGSize(width: 0, height: 10)
        self.shadowOpacity = 0.1
        self.shadowColor = UIColor.black.cgColor
    }
}
