//
//  HJLOTVendor.m
//  living
//
//  Created by lijia on 2019/11/14.
//  Copyright © 2019 MJHF. All rights reserved.
//

#import "HJLOTVendor.h"

@implementation HJLOTVendor

+(CompatibleAnimationView*)animationNamed:(NSString*)name {
    return [self animationNamed:name inBundle:NSBundle.mainBundle];
}

+(CompatibleAnimationView*)animationNamed:(NSString*)name inBundle:(NSBundle*)bundle {
    CompatibleAnimation *animation = [[CompatibleAnimation alloc] initWithName:name bundle:bundle];
    CompatibleAnimationView *animationView = [[CompatibleAnimationView alloc] initWithCompatibleAnimation:animation];
    return animationView;
}

+(CompatibleAnimationView*)animationWithAssetNamed:(NSString*)name {
    NSDataAsset *asset = [[NSDataAsset alloc] initWithName:name];
    CompatibleAnimationView *animationView = [[CompatibleAnimationView alloc] initWithData:asset.data cacheKey:name];
    return animationView;
}

+(CompatibleAnimationView*)animationWithContentsOfURL:(NSURL*)url {
    CompatibleAnimationView *animationView = [[CompatibleAnimationView alloc] initWithFrame:CGRectZero];
  [animationView loadAnimationFromUrl:url completion:^(BOOL success) {
    
  }];
    return animationView;
}
@end
