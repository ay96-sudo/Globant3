import UIKit

enum Endpoints : String {
    case resume = "gistfile1.txt"
}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

protocol NetworkingProtocol {
    func getImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
    func getData(endpoint: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}


final class Networking: NetworkingProtocol {
    
    private let session: URLSessionProtocol

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
    
    
    //MARK: - Fetching data from service
    func getData(endpoint: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
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
    
    
    //MARK: - Get Image from url
    func getImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                } else {
                    completion(.failure(.invalidData))
                }
            } else {
                completion(.failure(.fetchError))
            }
        }
    }
}
