import UIKit
@testable import Globant3

final class MockResumeService: ResumeServiceProtocol {
    
    var networking: NetworkingProtocol
    var getInformationWasCalled: Int = 0
    var getImageWasCalled: Int = 0

    init() {
       networking = MockNetworking()
    }
    
    //MARK: - Get Image from url
    func getImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        getImageWasCalled += 1
    }
    
    //MARK: - Parsing data to model
    func getInformation(endPoint: String, completion: @escaping (Result<Information, NetworkError>) -> Void) {
       getInformationWasCalled += 1
    }
}

