//
//  NSString+Extensions.swift
//  living
//
//  Created by lijia on 2021/12/17.
//  Copyright © 2021 MJHF. All rights reserved.
//

import Foundation

enum Regex {
    static let ipAddress = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
    static let hostname = "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$"
}

extension String {
    func isHostname() -> Bool {
        return self.matches(pattern: Regex.hostname)
    }
    
    func isIpAddress() -> Bool {
        return self.matches(pattern: Regex.ipAddress)
    }
    
    func isValidateIpAddress() -> Bool {
        return self.isIpv4() || self.isIpv6()
    }
        
    fileprivate func matches(pattern: String) -> Bool {
        return (self.range(of: pattern, options: .regularExpression) != nil)
    }
    
    fileprivate func isIpv4() -> Bool {
        var sin = sockaddr_in()
        let ret = self.withCString { cstr in
            inet_pton(AF_INET, cstr, &sin.sin_addr)
        }
        return (ret == 1)
    }
    
    fileprivate func isIpv6() -> Bool {
        var sin6 = sockaddr_in6()
        let ret = self.withCString { cstr in
            inet_pton(AF_INET6, cstr, &sin6.sin6_addr)
        }
        return (ret == 1)
    }

}

extension NSString {
    @objc func isHostname() -> Bool {
        return (self as String).isHostname()
    }
    
    @objc func isIpAddress() -> Bool {
        return (self as String).isIpAddress()
    }
    
    @objc func isValidateIpAddress() -> Bool {
        return (self as String).isValidateIpAddress()
    }
}
