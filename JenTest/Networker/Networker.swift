//
//  Networker.swift
//  JenTest
//
//  Created by lijia on 2021/11/10.
//  Copyright © 2021 MJHF. All rights reserved.
//

import Foundation
import UIKit

protocol Networking {
    var delegate: NetworkingDelegate? { get set }
    
    func fetch<R: Request>(_ request: R, completion: @escaping (R.Output?, Error?) -> Void) -> URLSessionTask?
    func fetch<T: Decodable>(url: URL, completion: @escaping (T?, Error?) -> Void) -> URLSessionTask?
    func fetchWithCache<R: Request>(_ request: R, completion: @escaping (R.Output?, Error?) -> Void) -> URLSessionTask? where R.Output == UIImage
}

class Networker: Networking {
    private let imageCache = RequestCache<UIImage>()
    
    weak var delegate: NetworkingDelegate?
    
    func fetch<R: Request>(_ request: R, completion: @escaping (R.Output?, Error?) -> Void) -> URLSessionTask? {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.allHTTPHeaderFields = delegate?.headers(for: self)
        urlRequest.httpMethod = request.method.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [unowned self, weak delegate = delegate] data, _, error in
            var adata: Data? = data
            if let delegate = delegate {
                adata = delegate.networking(self, data: (adata, error))
            }
            
            guard let tdata = adata else {
                completion(nil, error)
                return
            }
            
            do {
                let output = try request.decode(tdata)
                completion(output, error)
            } catch {
                print("decode error")
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }
    
    func fetchWithCache<R: Request>(_ request: R, completion: @escaping (R.Output?, Error?) -> Void) -> URLSessionTask? where R.Output == UIImage {
        if let output = imageCache.response(for: request) {
            completion(output, nil)
            return nil;
        }
        
        return fetch(request) { [unowned self] output, error in
            if let output = output, error == nil {
                self.imageCache.saveResponse(output, for: request)
            }
            completion(output, error)
        }
    }
    
    func fetch<T: Decodable>(url: URL, completion: @escaping (T?, Error?) -> Void) -> URLSessionTask? {
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = delegate?.headers(for: self)
        urlRequest.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            var t:T? = nil
            defer {
                completion(t, error)
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                t = try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("decode error")
            }
        }
        task.resume()
        return task
    }
}

protocol NetworkingDelegate: AnyObject {
    func headers(for networking: Networking) -> [String: String]
    func networking(_ networking: Networking, data: (Data?, Error?)) -> Data?
}

extension NetworkingDelegate {
    func headers(for networking: Networking) -> [String: String] {
        [:]
    }
    
    func networking(_ networking: Networking, data: (Data?, Error?)) -> Data? {
        data.0
    }
}
