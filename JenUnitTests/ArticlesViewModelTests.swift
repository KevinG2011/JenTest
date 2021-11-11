//
//  ArticlesViewModelTests.swift
//  JenTest
//
//  Created by lijia on 2021/11/10.
//  Copyright © 2021 MJHF. All rights reserved.
//


import XCTest
import Foundation
@testable import JenTest

class ArticlesViewModelTests: XCTestCase {
    var viewModel: ArticlesViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = ArticlesViewModel(networker: MockNetworker())
    }
    
    func testArticlesAreFetchedCorrectly() {
        XCTAssert(viewModel.articles.isEmpty)
        viewModel.fetchArticles()
    }
}

class MockNetworker: Networking {
    func fetch(_ request: Request, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask? {
        let outputData: Data
        switch request {
        case is ArticleRequest:
            let article = Article(
                name: "Articel Name",
                description: "Article Description",
                image: URL(string: "https://image.com")!,
                id: "Articel ID",
                downloadedImage: nil)
            let articleData = ArticleData(article: article)
            let articles = Articles(data: [articleData])
            outputData = try! JSONEncoder().encode(articles)
        default:
            outputData = Data()
        }
        completion(outputData, nil)
        return nil
    }
}
