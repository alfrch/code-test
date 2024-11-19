//
//  NewsDetailVC.swift
//  code-test
//
//

import UIKit

class NewsDetailVC: UIViewController {
    
    private let newsItem: NewsItem
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLbl = UILabel()
    private let contentLbl = UILabel()
    private let imageView = UIImageView()

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
        configureView()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up constraints for scrollView
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Set up constraints for contentView
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        titleLbl.font = .boldSystemFont(ofSize: 24)
        titleLbl.numberOfLines = 0
        
        contentLbl.font = .systemFont(ofSize: 16)
        contentLbl.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLbl, contentLbl])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureView() {
        titleLbl.text = newsItem.title
        contentLbl.text = newsItem.content
        if let url = URL(string: newsItem.image) {
            loadImage(from: url, into: imageView)
        }
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                }
            }
        }.resume()
    }
}


