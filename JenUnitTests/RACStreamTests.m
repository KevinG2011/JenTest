//
//  RACStreamTests.m
//  RACStreamTests
//
//  Created by lijia on 2020/6/1.
//  Copyright © 2020 MJHF. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Frameworks.h"

typedef RACStream *(^streamWithValues)(NSArray *);
@interface RACStreamTests : XCTestCase
@property (nonatomic, copy) streamWithValues  sv;
@end

@implementation RACStreamTests

- (void)setUp {
    Class streamClass = RACSignal.class;
    self.sv = [^(NSArray *values) {
        RACStream *stream = [streamClass empty];

        for (id value in values) {
            stream = [stream concat:[streamClass return:value]];
        }

        return stream;
    } copy];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testReduceEach {
    RACSignal *signal = self.sv(@[
        RACTuplePack(@"foo", @"bar"),
        RACTuplePack(@"buzz", @"baz"),
        RACTuplePack(@"", @"_")
    ]);
    
    RACSignal *s = [signal reduceEach:^(NSString *a, NSString *b) {
        return [a stringByAppendingString:b];
    }];
    [s subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)testStart {
    RACSignal *s = [[RACSignal empty] startWith:@1];
    [s subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

@end
