import Foundation

enum NetworkError: Error {
    case fetchError
    case invalidData
    case urlNotFound
    case unknownError(Error?)
    case noJSONData
    
    var localizedDescription: String {
        switch self {
        case .fetchError:
            return "fetch_error".localize()
        case .invalidData:
            return "invalid_error".localize()
        case .urlNotFound:
            return "url_not_found".localize()
        case .unknownError(let error):
            return error?.localizedDescription ?? "fetch_error".localize()
        case .noJSONData:
            return "invalid_error".localize()
        }
    }
}
