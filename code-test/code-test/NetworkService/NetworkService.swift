//
//  NetworkService.swift
//  code-test
//
//

import Foundation

enum NetworkingError: Error {
    case invalidURL
    case noData
    case decodingFailed
    case otherError
}

protocol NetworkServiceProtocol: AnyObject {
    func request<T: Decodable>(url: String, completion: @escaping ((Result<T, Error>) -> Void))
}

public final class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    private init() {}
    
    func request<T: Decodable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(NetworkingError.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.noData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkingError.decodingFailed))
            }
        }.resume()
    }
}
