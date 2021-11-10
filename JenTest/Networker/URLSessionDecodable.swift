//
//  URLSessionDecodable.swift
//  JenTest
//
//  Created by lijia on 2021/11/10.
//  Copyright © 2021 MJHF. All rights reserved.
//

import Foundation

protocol URLSessionDecodable {
    init(from output: Data) throws
}

