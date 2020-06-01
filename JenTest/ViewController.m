//
//  ViewController.m
//  JenTest
//
//  Created by lijia on 2019/4/23.
//  Copyright © 2019 MJHF. All rights reserved.
//

#import "ViewController.h"
@import Lottie;

@interface ViewController ()
@property (nonatomic, weak) CompatibleAnimationView         *animationView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CompatibleAnimationView *animationView = [[CompatibleAnimationView alloc] initWithFrame:CGRectZero];
    animationView.loopAnimationCount = 2;
    animationView.backgroundColor = [UIColor redColor];
    animationView.center = self.view.center;
    animationView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.animationView = animationView];
    
    CompatibleAnimation *animation;
    animation = [[CompatibleAnimation alloc] initWithName:@"data" bundle:[NSBundle mainBundle]];
    animationView.compatibleAnimation = animation;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.animationView playWithCompletion:^(BOOL a) {
        
    }];
    
    for (int i = 0; i < 5; ++i) {
        [self.animationView play];
        usleep(0.2 * 1000);
        NSLog(@"%d", i);
    }
}


@end
