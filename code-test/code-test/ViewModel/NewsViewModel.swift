//
//  NewsViewModel.swift
//  code-test
//
//

import Foundation

class NewsViewModel {
    private var newsItems: [NewsItem] = []
    var onFetchNews: ((_ error: String?) -> Void)?
    
    func fetchNews() {
        guard let url = URL(string: "https://jsonplaceholder.org/posts") else {
            onFetchNews?("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                self?.onFetchNews?(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                self?.onFetchNews?("No data received")
                return
            }
            
            do {
                let items = try JSONDecoder().decode([NewsItem].self, from: data)
                self?.newsItems = items
                
                DispatchQueue.main.async {
                    self?.onFetchNews?(nil)
                }
            } catch {
                self?.onFetchNews?("Failed to decode data")
            }
        }.resume()
    }
    
    func numberOfItems() -> Int {
        return newsItems.count
    }
    
    func item(at index: Int) -> NewsItem {
        return newsItems[index]
    }
}
