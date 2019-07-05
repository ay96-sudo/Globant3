import UIKit

//MARK: - Extension for UILabel
extension UILabel {
    func configure(text: String, font: UIFont, numberOfLines: Int = 0){
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}
