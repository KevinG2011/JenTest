//
//  HJLOTVendor.h
//  living
//
//  Created by lijia on 2019/11/14.
//  Copyright © 2019 MJHF. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Lottie;

NS_ASSUME_NONNULL_BEGIN

@interface HJLOTVendor : NSObject
+(CompatibleAnimationView*)animationNamed:(NSString*)name;
+(CompatibleAnimationView*)animationNamed:(NSString*)name
                                 inBundle:(NSBundle*)bundle;
+(CompatibleAnimationView*)animationWithAssetNamed:(NSString*)name;

+(CompatibleAnimationView*)animationWithContentsOfURL:(NSURL*)url;
@end

NS_ASSUME_NONNULL_END
