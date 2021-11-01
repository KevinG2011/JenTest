//
//  NSDictionary+HJBlocks.m
//  living
//
//  Created by lijia on 2018/9/4.
//  Copyright © 2018年 MJHF. All rights reserved.
//

#import "NSDictionary+HJBlocks.h"

@implementation NSDictionary (HJBlocks)
- (void)hj_each:(void (NS_NOESCAPE ^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(key, obj);
    }];
}

- (void)hj_apply:(void (NS_NOESCAPE ^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    [self enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id key, id obj, BOOL *stop) {
        block(key, obj);
    }];
}

- (id)hj_match:(BOOL (NS_NOESCAPE ^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    return self[[[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        if (block(key, obj)) {
            *stop = YES;
            return YES;
        }
        
        return NO;
    }] anyObject]];
}

- (NSDictionary *)hj_select:(BOOL (NS_NOESCAPE ^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    NSArray *keys = [[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        return block(key, obj);
    }] allObjects];
    
    NSArray *objects = [self objectsForKeys:keys notFoundMarker:[NSNull null]];
    return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (NSDictionary *)hj_reject:(BOOL (NS_NOESCAPE ^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    return [self hj_select:^BOOL(id key, id obj) {
        return !block(key, obj);
    }];
}

- (NSDictionary *)hj_map:(id (NS_NOESCAPE ^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    [self hj_each:^(id key, id obj) {
        id value = block(key, obj);
        if (value) {
            result[key] = value;
        }
    }];
    
    return [result copy];
}

- (NSArray *)hj_listMap:(id (NS_NOESCAPE ^)(id key, id obj))block {
    NSParameterAssert(block != nil);
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    [self hj_each:^(id key, id obj) {
        id value = block(key, obj);
        if (value) {
            [result addObject:value];
        }
    }];
    return [result copy];
}

- (BOOL)hj_any:(BOOL (NS_NOESCAPE ^)(id key, id obj))block
{
    return [self hj_match:block] != nil;
}

- (BOOL)hj_none:(BOOL (NS_NOESCAPE ^)(id key, id obj))block
{
    return [self hj_match:block] == nil;
}

- (BOOL)hj_all:(BOOL (NS_NOESCAPE ^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    __block BOOL result = YES;
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (!block(key, obj)) {
            result = NO;
            *stop = YES;
        }
    }];
    
    return result;
}
@end
