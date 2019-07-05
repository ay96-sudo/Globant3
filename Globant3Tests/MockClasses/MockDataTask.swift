import Foundation
@testable import Globant3

final class MockDataTask: URLSessionDataTask {
    var completionHandler: (Data?, URLResponse?, Error?) -> Void
    
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        //Override for not connect to anything.
        debugPrint("resume_local".localize())
    }
}
