//
//  NewsCell.swift
//  code-test
//
//

import UIKit

class NewsCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let thumbnailImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .gray

        let stackView = UIStackView(arrangedSubviews: [thumbnailImageView, titleLabel, dateLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 80),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    func configure(with newsItem: NewsItem) {
        titleLabel.text = newsItem.title
        dateLabel.text = newsItem.publishedAt
        if let url = URL(string: newsItem.thumbnail) {
            loadImage(from: url, into: thumbnailImageView)
        }
    }

    private func loadImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }.resume()
    }
}


