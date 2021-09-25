//
//  ViewController.m
//  JenTest
//
//  Created by lijia on 2019/4/23.
//  Copyright © 2019 MJHF. All rights reserved.
//

#import "ViewController.h"
#import <PromiseKit/PMKFoundation.h>

@interface ViewController ()
//@property (nonatomic, weak) CompatibleAnimationView         *animationView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testPromise];
}

- (void)testPromise {
        dispatch_promise(^{
          return @2;
        }).then(^(NSNumber *x){
          NSLog(@"%@", x);
        });
        NSURL *url1 = [NSURL URLWithString:@"https://avatars.githubusercontent.com/u/47217137?s=96&v=4"];
        NSURLRequest *req1 = [NSURLRequest requestWithURL:url1];
        AnyPromise *p1 = [NSURLSession.sharedSession promiseDataTaskWithRequest:req1];
    
        NSURL *url2 = [NSURL URLWithString:@"https://avatars.githubusercontent.com/u/47217138?s=96&v=4"];
        NSURLRequest *req2 = [NSURLRequest requestWithURL:url2];
        AnyPromise *p2 = [NSURLSession.sharedSession promiseDataTaskWithRequest:req2];
        PMKWhen(@[p1, p2]).then(^(NSArray *results) {
            NSLog(@"%@", results.firstObject);
            NSLog(@"%@", results.lastObject);
        }).catch(^{
            NSLog(@"catch error");
        });
}

- (IBAction)onPromiseClick:(id)sender {
    AnyPromise *myPromise = [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull resolver) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            uint32_t random = arc4random();
            if (random % 2 == 0) {
                resolver(@(random));
            } else {
                NSError *error = [NSError errorWithDomain:@"AnyPromiseResolverError" code:random userInfo:nil];
                resolver(error);
            }
        });
    }];
    
    myPromise.then(^(NSNumber *value) {
        NSLog(@"value :%@", value);
    }).ensure(^ {
        NSLog(@"ensure");
    }).catch(^(NSError *err) {
        NSLog(@"error :%@", err);
    });
}


@end
