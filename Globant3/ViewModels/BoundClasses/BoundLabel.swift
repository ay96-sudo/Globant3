import UIKit

final class BoundLabel: UILabel {
    func bind(to observable: Observable<String>) {
        observable.valueChanged = { [weak self] newValue in
            self?.text = newValue
        }
    }
    
    func bind(to observableArray: Observable<[String]>) {
        observableArray.valueChanged = { [weak self] newValue in
            self?.text = newValue?.joined(separator: "\n")
        }
    }
}
