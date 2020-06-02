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
        
        XCTestExpectation *expectation = [self expectationWithDescription:@"符合预期的流状态"];
        NSMutableArray *collectedValues = [NSMutableArray array];
        
        __block BOOL success = NO;
        __block NSError *signalError = nil;
        [signal subscribeNext:^(id value) {
            [collectedValues addObject:value];
        } error:^(NSError *receivedError) {
            signalError = receivedError;
        } completed:^{
            success = YES;
            [expectation fulfill];
        }];
        
        [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
            XCTAssertTrue(success);
            XCTAssertNil(signalError);
            XCTAssertEqualObjects(collectedValues, expectedValues);
        }];
    };
}

- (void)tearDown {
    self.verifyValues = nil;
}

///Test empty
- (void)testEmpty {
    RACSignal *s = [RACSignal empty];
    
    self.verifyValues(s, @[]);
}

///Test return
- (void)testReturn {
    RACSignal *s = [RACSignal return:@2];
    self.verifyValues(s, @[@2]);
}

- (void)testZip {
    RACSignal *s = [RACSignal zip:@[[RACSignal return:@1],
                                    [RACSignal return:@2],
                                    [RACSignal return:@3]]];
    
    [s subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
        XCTAssertTrue([x isKindOfClass:RACTuple.class]);
    }];
}

- (void)testZipReduce {
    RACSignal *s = [RACSignal zip:@[[RACSignal return:@1],
                                    [RACSignal return:@2],
                                    [RACSignal return:@3]] reduce:^ NSString * (id x, id y, id z) {
        return [NSString stringWithFormat:@"%@ %@ %@", x, y, z];
    }];
    
    [s subscribeNext:^(id  _Nullable x) {
        NSLog(@"============================: %@", x);
        XCTAssertEqualObjects(x, @"1 2 3");
    }];
}


- (void)testConcate {
    RACSignal *s = [[RACSignal return:@0] concat:[RACSignal return:@1]];
    self.verifyValues(s, @[@0, @1]);
}

- (void)testScanWithStart {
    RACSequence *numbers = @[ @1, @2, @3, @4 ].rac_sequence;
    RACSequence *seq = [numbers scanWithStart:@0 reduce:^id _Nullable(NSNumber* running, NSNumber* next) {
        return @(running.integerValue + next.integerValue);
    }];
    self.verifyValues(seq.signal, @[@1, @3, @6, @10]);
}

- (void)testTakeWhileBlock {
    RACSequence *numbers = @[ @1, @2, @3, @4 ].rac_sequence;
    RACSequence *seq = [numbers takeWhileBlock:^ BOOL (NSNumber *x) {
        return x.integerValue <= 2;
    }];

    self.verifyValues(seq.signal, @[ @1, @2 ]);
}

- (void)testTakeUntilBlock {
    RACSequence *numbers = @[ @1, @2, @3, @4 ].rac_sequence;
    RACSequence *seq = [numbers takeUntilBlock:^ BOOL (NSNumber *x) {
        return x.integerValue > 3;
    }];

    self.verifyValues(seq.signal, @[ @1, @2, @3 ]);
}

- (void)testSkipUntilBlock {
    RACSequence *numbers = @[ @1, @2, @3, @4 ].rac_sequence;
    RACSequence *seq = [numbers skipUntilBlock:^ BOOL (NSNumber *x) {
        return x.integerValue > 3;
    }];

    self.verifyValues(seq.signal, @[ @4 ]);
}

- (void)testSkipWhileBlock {
    RACSequence *numbers = @[ @1, @2, @3, @4 ].rac_sequence;
    RACSequence *seq = [numbers skipWhileBlock:^ BOOL (NSNumber *x) {
        return x.integerValue > 0;
    }];

    self.verifyValues(seq.signal, @[]);
}

- (void)testCreateSignal {
    RACSignal *s = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [[RACScheduler currentScheduler] afterDelay:0.5 schedule:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"==================== dispose ==============");
        }];
    }];
    self.verifyValues(s, @[@1]);
}

- (void)testStartEagerlyWithScheduler {
    __block NSUInteger count = 0;
    RACSignal *s = [RACSignal startEagerlyWithScheduler:[RACScheduler currentScheduler] block:^(id<RACSubscriber>  _Nonnull subscriber) {
        for (id num in @[@1, @2, @3]) {
            [subscriber sendNext:num];
        }
        NSLog(@"==================== :%zd", ++count);
        [subscriber sendCompleted];
    }];
    
    self.verifyValues(s, @[@1, @2, @3]);
}

- (void)testStartLazilyWithScheduler {
    RACSignal *s = [RACSignal startLazilyWithScheduler:[RACScheduler currentScheduler] block:^(id<RACSubscriber>  _Nonnull subscriber) {
        for (id num in @[@1, @2, @3]) {
            [subscriber sendNext:num];
        }
        [subscriber sendCompleted];
    }];
    self.verifyValues(s, @[@1, @2, @3]);
}

- (void)testConcat {
    RACSignal *s = [[[RACSignal return:@0] concat:[RACSignal empty]] concat:[RACSignal return:@2]];
    self.verifyValues(s, @[ @0, @2 ]);
}


- (void)testZipWith {
    RACSignal *<#signal#> = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:<#value#>];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            <#dispose#>
        }];
    }];
    
    [<#signal#> subscribeNext:^(id  _Nullable x) {
        
    } completed:^{
        
    }];
}


@end
