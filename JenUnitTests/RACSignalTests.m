//
//  RACSignalTests.m
//  JenUnitTests
//
//  Created by lijia on 2020/6/1.
//  Copyright © 2020 MJHF. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Frameworks.h"

@interface RACSignalTests : XCTestCase

@end

@implementation RACSignalTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


///Test Sequence
- (void)testSequence {
    RACSignal *signal =  @[@1,@2].rac_sequence.signal;
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
}

///Test empty
- (void)testEmpty {
    RACStream *stream = [RACSignal empty];
    
}

///Test return
- (void)testReturn {
    
}

- (void)testZip {
    
    RACSignal *s = [RACSignal zip:@[[RACSignal return:@1],
                                    [RACSignal return:@2],
                                    [RACSignal return:@3]]];
    
    [s subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)testZipReduce {
    
    RACSignal *s = [RACSignal zip:@[[RACSignal return:@1],
                                    [RACSignal return:@2],
                                    [RACSignal return:@3]] reduce:^ NSString * (id x, id y, id z) {
        return [NSString stringWithFormat:@"%@ %@ %@", x, y, z];
    }];
    
    [s subscribeNext:^(id  _Nullable x) {
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
