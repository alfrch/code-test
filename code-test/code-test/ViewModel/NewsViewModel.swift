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
        NewsService.shared.fetchNews(responseType: [NewsItem].self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.newsItems = response
                
                DispatchQueue.main.async {
                    self?.onFetchNews?(nil)
                }
            case .failure(let error):
                self?.onFetchNews?(error.localizedDescription)
            }
        }
    }
    
    func numberOfItems() -> Int {
        return newsItems.count
    }
    
    func item(at index: Int) -> NewsItem {
        return newsItems[index]
    }
}
