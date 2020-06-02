//
//  RACRequenceTests.m
//  JenUnitTests
//
//  Created by lijia on 2020/6/2.
//  Copyright © 2020 MJHF. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Frameworks.h"

@interface RACRequenceTests : XCTestCase

@end

@implementation RACRequenceTests

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
@end
