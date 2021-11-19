//
//  Request.swift
//  JenTest
//
//  Created by lijia on 2021/11/10.
//  Copyright © 2021 MJHF. All rights reserved.
//

import Foundation
enum HTTPMethod: String {
    case `get` = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol Request {
    var url: URL { get }
    var method: HTTPMethod { get }
    associatedtype Output
    func decode(_ data: Data) throws -> Output
}

extension Request where Output: Decodable {
    func decode(_ data: Data) throws -> Output {
        let decoder = JSONDecoder()
        return try decoder.decode(Output.self, from: data)
    }
}

struct AnyRequest: Hashable {
    var url: URL
    var method: HTTPMethod
}
