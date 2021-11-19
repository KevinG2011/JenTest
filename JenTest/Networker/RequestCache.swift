//
//  RequestCache.swift
//  JenTest
//
//  Created by lijia on 2021/11/18.
//  Copyright © 2021 MJHF. All rights reserved.
//

import Foundation
import UIKit

class RequestCache<Value> {
    private var store: [AnyRequest: Value] = [:]
    
    func response<R: Request>(for request: R) -> Value? where R.Output == Value {
        let erasedRequest = AnyRequest(url: request.url, method: request.method)
        return store[erasedRequest];
    }
    
    func saveResponse<R: Request>(_ response: Value, for request: R) where R.Output == Value {
        let erasedRequest = AnyRequest(url: request.url, method: request.method)
        store[erasedRequest] = response
    }
}
