import UIKit
@testable import Globant3

final class MockNetworking: NetworkingProtocol {
    
    private let session: URLSessionProtocol
   
    // Testing observers
    var getDataWasCalled: Int = 0
    var getImageWasCalled: Int = 0
    var getModelWasCalled: Int = 0
    
    //MARK: - Information required for API
    private var baseURLString: String?
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
        baseURLString = getServerURL(from: "SERVER_URL")
    }
    
    //MARK: - Auxiliar function for read serverURL
    private func getServerURL(from key: String) -> String? {
        guard let serverURL = try? Configuration.valueFor(key: key) else {
            return nil
        }
        return serverURL
    }
    
    func getData(endpoint: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        getDataWasCalled += 1
        if let urlString = baseURLString, let url = URL(string: urlString) {
            session.dataTask(with: url.appendingPathComponent(endpoint)) { data, response, error in
                
                guard error == nil else {
                    return completion(.failure(.unknownError(error)))
                }
                guard let response = response else {
                    return completion(.failure(.noJSONData))
                }
                
                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.fetchError))
                    return
                }
                switch httpResponse.statusCode {
                case 200...299:
                    completion(.success(data))
                default:
                    return completion(.failure(.unknownError(nil)))
                }
                }.resume()
        }
    }
    
    var data: Data?
    
    func getModel(completion: @escaping (Information?) -> Void) {
        getModelWasCalled += 1
        let jsonDecoder = JSONDecoder()
        guard let data = data else { return }
        guard let json = try? jsonDecoder.decode(Information.self, from: data) else {
            completion(nil)
            return
        }
        completion(json)
    }
    
    func getImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        getImageWasCalled += 1
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.invalidData))
            }
        } else {
            completion(.failure(.fetchError))
        }
    }
    
}
