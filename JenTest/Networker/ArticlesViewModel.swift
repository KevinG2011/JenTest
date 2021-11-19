//
//  ArticlesViewModel.swift
//  JenTest
//
//  Created by lijia on 2021/11/10.
//  Copyright © 2021 MJHF. All rights reserved.
//

import Foundation
import UIKit

final class ArticlesViewModel {
    private(set) var articles: [Article] = []
    private var networker: Networking
    
    init(networker: Networking) {
        self.networker = networker
    }
    
    func fetchArticles() {
        let request = ArticleRequest()
        let _ = networker.fetch(request) { [unowned self] data, error in
            guard let data = data else {
                print("URLSession dataTask error:", error ?? "nil")
                self.articles = []
                return
            }
            DispatchQueue.main.async {
                self.articles = data
                self.articles.forEach { print($0.name) }
            }
        }
    }
    
    func fetchImage(for article: Article) {
        guard article.downloadedImage == nil, var findArticle = articles.first(where: { $0.id == article.id }) else {
            return
        }
        let request = ImageRequest(url: article.image)
        let _ = networker.fetchWithCache(request) { image, error in
            guard let image = image else {
                print("URLSession dataTask error:", error ?? "nil")
                return
            }
            findArticle.downloadedImage = image
        }
    }
}

extension ArticlesViewModel: NetworkingDelegate {
    func headers(for networking: Networking) -> [String: String] {
        ["Content-Type": "application/vnd.api+json; charset=utf-8"]
    }
}
