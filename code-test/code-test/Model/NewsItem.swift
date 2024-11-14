//
//  NewsItem.swift
//  code-test
//
//

import Foundation

struct NewsItem: Decodable {
    let id: Int
    let title: String
    let content: String
    let image: String
    let thumbnail: String
    let publishedAt: String
}
