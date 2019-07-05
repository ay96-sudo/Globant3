import UIKit

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "String not localizable")
    }
}
