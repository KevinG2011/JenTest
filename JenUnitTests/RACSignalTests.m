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
@property (nonatomic, copy) void(^verifyValues)(RACSignal *signal, NSArray *expectedValues);
@end

@implementation RACSignalTests

- (void)setUp {
    @weakify(self)
    self.verifyValues = ^(RACSignal *signal, NSArray *expectedValues) {
        @strongify(self)
        NSMutableArray *collectedValues = [NSMutableArray array];

        __block BOOL success = NO;
        __block NSError *error = nil;
        [signal subscribeNext:^(id value) {
            [collectedValues addObject:value];
        } error:^(NSError *receivedError) {
            error = receivedError;
        } completed:^{
            success = YES;
        }];
        
        XCTAssertTrue(success);
        XCTAssertNil(error);
    };
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
    RACSignal *s = [RACSignal empty];
}

///Test return
- (void)testReturn {
    RACSignal *s = [RACSignal return:@2];
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


- (void)testConcate {
    RACSignal *s = [[RACSignal return:@0] concat:[RACSignal return:@1]];
    self.verifyValues(s, @[@0, @1]);
}

@end
