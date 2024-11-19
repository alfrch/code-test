//
//  NewsService.swift
//  code-test
//
//

import Foundation

protocol NewsServiceProtocol {
    func fetchNews<T: Decodable>(responseType: T.Type, completion: @escaping ((Result<T, Error>) -> Void))
}

class NewsService: NewsServiceProtocol {
    static let shared = NewsService()
    
    func fetchNews<T: Decodable>(responseType: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) {
        NetworkService.shared.request(url: "https://jsonplaceholder.org/posts") { result in
            completion(result)
        }
    }
}
