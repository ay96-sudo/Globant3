import Foundation

enum KeyErrors: Error {
    case badKey
}

enum Configuration {
    static func valueFor(key: String) throws -> String? {
        do {
            guard let value = Bundle.main.infoDictionary?[key] as? String else {
                throw KeyErrors.badKey
            }
            return value
        } catch {
            return nil
        }
    }
}
