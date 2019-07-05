import Foundation
import UIKit

protocol ResumeServiceProtocol {
    var networking: NetworkingProtocol {get set}
    func getInformation(endPoint: String, completion: @escaping (Result<Information, NetworkError>) -> Void)
    func getImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}


final class ResumeService: ResumeServiceProtocol {
    var networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol = Networking()) {
        self.networking = networking
    }
    
    //MARK: - Get Image from url
    func getImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        self.networking.getImage(from: url) { result in
            completion(result)
        }
    }
    
    //MARK: - Parsing data to model
    func getInformation(endPoint: String, completion: @escaping (Result<Information, NetworkError>) -> Void) {
        networking.getData(endpoint: endPoint) { result in
            switch result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let modelObject = try? jsonDecoder.decode(Information.self, from: data) {
                    completion(Result.success(modelObject))
                } else {
                    completion(Result.failure(.invalidData))
                }
            case .failure(let reason):
                completion(Result.failure(reason))
            }
        }
    }
}
