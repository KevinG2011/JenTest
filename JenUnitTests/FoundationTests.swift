//
//  FoundationTests.swift
//  JenUnitTests
//
//  Created by lijia on 2021/12/23.
//  Copyright © 2021 MJHF. All rights reserved.
//

import XCTest

class FoundationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFilter() throws {
        let airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        let newports = airports.filter {$0.value == "Dublin"}
        print(newports)
    }
    
    func testStringReplacing() throws {
        var urlString = "live.huajiao.com"
        let host = "live"
        urlString = urlString.replacingOccurrences(of: host, with: "live.test")
        XCTAssertEqual(urlString, "live.test.huajiao.com")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
