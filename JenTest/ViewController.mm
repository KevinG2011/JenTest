//
//  ViewController.m
//  JenTest
//
//  Created by lijia on 2019/4/23.
//  Copyright © 2019 MJHF. All rights reserved.
//

#import "ViewController.h"
//#import <OgreEngine/MTOgreManager.h>
#import "HJLOTVendor.h"
#import "NSString+Ext.h"
#import "UIColor+Hex.h"
#import <YYCategories/YYCategories.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet CompatibleAnimationView *coderAnimationView;
@property (nonatomic, weak) CompatibleAnimationView         *animationView;
@property (nonatomic) dispatch_semaphore_t lock;
@end

@implementation ViewController

- (void)playAnimationFilePath:(NSString*)filePath
                   completion:(void(^)(BOOL success))completion {
    NSString *animationName = filePath.lastPathComponent.stringByDeletingPathExtension;
    NSLog(@"animationName: %@", animationName);
    CompatibleAnimationView *animationView = [HJLOTVendor animationNamed:animationName];
//    animationView.frame = CGRectMake(150, 250, 50, 50);
    animationView.loopAnimationCount = 2;
    animationView.backgroundColor = [UIColor grayColor];
    animationView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.animationView = animationView];
    self.animationView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.animationView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.5f].active = YES;
    [self.animationView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.3f].active = YES;
    [self.animationView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.animationView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
    __weak typeof(self) weakSelf = self;
    [self.animationView playWithCompletion:^(BOOL success) {
        [weakSelf.animationView removeFromSuperview];
        weakSelf.animationView = nil;
        if (completion) {
            completion(YES);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.imageView.image = [UIImage imageNamed:@"live_aura_off"];
//    self.imageView.tintColor = [UIColor whiteColor];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.imageView.tintColor = [UIColor colorForHex:@"30FFB9"];
//    });
//    self.coderAnimationView.hidden = YES;
//    self.lock = dispatch_semaphore_create(0);
//    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        NSString *bundlePath = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@""];
//        NSArray<NSString*> *fileNames = [NSFileManager.defaultManager contentsOfDirectoryAtPath:bundlePath error:nil];
//        for (NSString *fileName in fileNames) {
//            if (![[fileName pathExtension] isEqualToString:@"json"]) {
//                continue;
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSString *filePath = [bundlePath stringByAppendingPathComponent:fileName];
//                [self playAnimationFilePath:filePath completion:^(BOOL success) {
//                    dispatch_semaphore_signal(self.lock);
//                }];
//            });
//            dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
//        }
//    });
}

@end
