//
//  ArticleRequest.swift
//  JenTest
//
//  Created by lijia on 2021/11/10.
//  Copyright © 2021 MJHF. All rights reserved.
//

import Foundation

struct ArticleRequest: Request {
    typealias Output = [Article]
    var url: URL {
        let baseURL = "https://api.raywenderlich.com/api"
        let path = "/contents?filter[content_types][]=article"
        return URL(string: baseURL + path)!
    }
    var method: HTTPMethod { .get }
}
