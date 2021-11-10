//
//  Networker.swift
//  JenTest
//
//  Created by lijia on 2021/11/10.
//  Copyright © 2021 MJHF. All rights reserved.
//

import Foundation

protocol Networking {
    func fetch(_ request: Request, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask?
}


class Networker: Networking {
    func fetch(_ request: Request, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask? {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            completion(data, error)
        }
        task.resume()
        return task
    }
}
