//
//  NSString+Ext.h
//  living
//
//  Created by lych on 15/5/13.
//  Copyright (c) 2015年 MJHF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ext)

+ (NSString *)urlWithBaseUrlStr:(NSString *)baseUrlStr
                       parmeter:(NSDictionary<NSString *, NSString *> *)parmeter;

- (BOOL)isNotEmpty;

@end
