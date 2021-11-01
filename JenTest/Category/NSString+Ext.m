//
//  NSString+Ext.m
//  living
//
//  Created by lych on 15/5/13.
//  Copyright (c) 2015年 MJHF. All rights reserved.
//

#import "NSString+Ext.h"
#import "NSArray+HJBlocks.h"
#import "NSDictionary+HJBlocks.h"

@implementation NSString (Ext)

+ (NSString *)urlWithBaseUrlStr:(NSString *)baseUrlStr
                       parmeter:(NSDictionary<NSString *, NSString *> *)params {
    NSURL *baseURL = [NSURL URLWithString:baseUrlStr];
    if (baseURL == nil) {
        NSString *encodingUrlStr = [baseUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        baseURL = [NSURL URLWithString:encodingUrlStr];
    }
    
    if (baseURL == nil) {
        return baseUrlStr;
    }
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:NO];
    if (components) {
        NSMutableDictionary<NSString*, NSString*> *queryParams = [NSMutableDictionary dictionaryWithDictionary:params];
        [components.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([item.value isKindOfClass:NSString.class] || [item.value isKindOfClass:NSNumber.class]) {
                if ([item.name isNotEmpty]) {
                    queryParams[item.name] = item.value;
                }
            }
        }];
        
        NSArray<NSURLQueryItem*> *queryItems = [queryParams hj_listMap:^id(NSString *key, NSString *value) {
            return [NSURLQueryItem queryItemWithName:key value:value];
        }];
        
        components.queryItems = queryItems;
    } else {
        NSLog(@"base url err !! url = %@", baseUrlStr);
    }
    NSString *encodingQuery = [components.query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *resultUrlStr = [NSString stringWithFormat:@"%@://%@%@?%@", baseURL.scheme, baseURL.host, baseURL.path, encodingQuery];
    if (![resultUrlStr isNotEmpty]) {
        resultUrlStr = baseUrlStr;
    }
    return resultUrlStr;
}

- (BOOL)isNotEmpty {
    return (self != nil
            && [self isKindOfClass:NSString.class]
            && [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0
            && ![self isEqual:[NSNull null]]);
}
@end
