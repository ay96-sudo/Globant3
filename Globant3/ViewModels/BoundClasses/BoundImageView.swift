import UIKit

final class BoundImageView: UIImageView {
    func bind(to observable: Observable<UIImage>) {
        observable.valueChanged = {[weak self] newValue in
            self?.image = newValue
        }
    }
}
