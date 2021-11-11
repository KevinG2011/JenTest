//
//  Networker.swift
//  JenTest
//
//  Created by lijia on 2021/11/10.
//  Copyright © 2021 MJHF. All rights reserved.
//

import Foundation

protocol Networking {
    var delegate: NetworkingDelegate? { get set }
    
    func fetch(_ request: Request, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask?
}

class Networker: Networking {
    weak var delegate: NetworkingDelegate?
    
    func fetch(_ request: Request, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask? {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.allHTTPHeaderFields = delegate?.headers(for: self)
        urlRequest.httpMethod = request.method.rawValue
        let task = URLSession.shared.dataTask(with: urlRequest) { [unowned  self, weak delegate = delegate] data, _, error in
            completion(data, error)
            let _ = delegate?.networking(self, data: (data, error))
        }
        task.resume()
        return task
    }
}

protocol NetworkingDelegate: AnyObject {
    func headers(for networking: Networking) -> [String: String]
    func networking(_ networking: Networking, data: (Data?, Error?)) -> (Data?, Error?)
}

extension NetworkingDelegate {
    func headers(for networking: Networking) -> [String: String] {
        [:]
    }
    
    func networking(_ networking: Networking, data: (Data?, Error?)) -> (Data?, Error?) {
        data
    }
}
