//
//  NewsVC.swift
//  code-test
//
//

import UIKit

class NewsVC: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero)
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.showsVerticalScrollIndicator = false
        tb.backgroundColor = .clear
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 44
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    private let viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        viewModel.fetchNews()
    }

    private func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onFetchNews = { [weak self] errorMessage in
            guard let errorMessage = errorMessage else {
                self?.tableView.reloadData()
                return
            }
            
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(alert, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate

extension NewsVC: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "cell \(indexPath.row)"
        return cell
    }
    
    
}
