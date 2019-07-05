import Foundation
@testable import Globant3

final class MockURLSession: URLSessionProtocol {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionDataTask {
        defer { completionHandler(data, response, error) }
        return MockDataTask(completionHandler: completionHandler)
    }
}
