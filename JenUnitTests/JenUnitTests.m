//
//  JenUnitTests.m
//  JenUnitTests
//
//  Created by lijia on 2020/6/1.
//  Copyright © 2020 MJHF. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface JenUnitTests : XCTestCase

@end

@implementation JenUnitTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    RACSignal *signal =  @[@1,@2].rac_sequence.signal;
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
