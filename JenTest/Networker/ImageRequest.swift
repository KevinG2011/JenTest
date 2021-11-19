//
//  ImageRequest.swift
//  JenTest
//
//  Created by lijia on 2021/11/18.
//  Copyright © 2021 MJHF. All rights reserved.
//

import UIKit

enum DataError: Swift.Error {
    case invalidData
}

struct ImageRequest: Request {
    typealias Output = UIImage
    let url: URL
    var method: HTTPMethod { .get }
    
    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw DataError.invalidData
        }
        return image
    }
}
