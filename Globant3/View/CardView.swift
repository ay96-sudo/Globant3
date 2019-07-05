import UIKit

 final class CardView: UIView {
    var bottomColor: UIColor = UIColor(red: 255 / 255, green: 234 / 255, blue: 254 / 255, alpha: 1.0)
    var topColor: UIColor = UIColor(red: 204 / 255, green: 193 / 255, blue: 255 / 255, alpha: 1.0)
    var cornerRadius: CGFloat = 30 {
        didSet {
            updateCornerRadius()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as? CAGradientLayer)?.colors = [topColor.cgColor, bottomColor.cgColor]
    }
    
    private func updateCornerRadius() {
        layer.cornerRadius = cornerRadius
    }
}
