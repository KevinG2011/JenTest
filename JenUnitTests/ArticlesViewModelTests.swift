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
    var delegate: NetworkingDelegate?
    
    func fetch<R: Request>(_ request: R, completion: @escaping (R.Output?, Error?) -> Void) -> URLSessionTask? {
        var output: R.Output?
        switch request {
            case is ArticleRequest:
                let article = Article(
                    name: "Articel Name",
                    description: "Article Description",
                    image: URL(string: "https://image.com")!,
                    id: "Articel ID",
                    downloadedImage: nil)
                let articleData = ArticleData(article: article)
                output = Articles(data: [articleData]) as? R.Output
            default: break
        }
        completion(output, nil)
        return nil
    }
    
    func fetch<T: Decodable>(url: URL, completion: @escaping (T?, Error?) -> Void) -> URLSessionTask? {
        return nil
    }
    
    func fetchWithCache<R: Request>(_ request: R, completion: @escaping (R.Output?, Error?) -> Void) -> URLSessionTask? where R.Output == UIImage {
        return nil
    }
}
