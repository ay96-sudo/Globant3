import UIKit

final class Observable<ObservedType> {
    private var _value: ObservedType?
    var value: ObservedType? {
        get {
            return _value
        }
        set {
            _value = newValue
            valueChanged?(_value)
        }
    }
    var valueChanged: ((ObservedType?) -> Void)?
    
    init(_ value: ObservedType) {
        _value = value
    }
}
