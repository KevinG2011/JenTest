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
}
