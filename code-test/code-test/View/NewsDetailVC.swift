//
//  NewsDetailVC.swift
//  code-test
//
//

import UIKit

class NewsDetailVC: UIViewController {
    
    private let newsItem: NewsItem

    init(newsItem: NewsItem) {
        self.newsItem = newsItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
    }
}


