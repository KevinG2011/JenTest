//
//  NSArray+HJBlocks.m
//  living
//
//  Created by lijia on 2018/9/4.
//  Copyright © 2018年 MJHF. All rights reserved.
//

#import "NSArray+HJBlocks.h"

@implementation NSArray (HJBlocks)
- (void)hj_each:(void (NS_NOESCAPE ^)(id obj))block
{
    NSParameterAssert(block != nil);
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (void)hj_apply:(void (NS_NOESCAPE ^)(id obj))block
{
    NSParameterAssert(block != nil);
    
    [self enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (id)hj_match:(BOOL (NS_NOESCAPE ^)(id obj))block
{
    NSParameterAssert(block != nil);
    
    NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BOOL ret = block(obj);
        if (ret) {
            *stop = YES;
        }
        return ret;
    }];
    
    if (index == NSNotFound)
        return nil;
    
    return self[index];
}

- (NSArray *)hj_select:(BOOL (NS_NOESCAPE ^)(id obj))block
{
    NSParameterAssert(block != nil);
    return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return block(obj);
    }]];
}

- (NSArray *)hj_reject:(BOOL (NS_NOESCAPE ^)(id obj))block
{
    NSParameterAssert(block != nil);
    return [self hj_select:^BOOL(id obj) {
        return !block(obj);
    }];
}

- (NSArray *)hj_map:(id (NS_NOESCAPE ^)(id obj))block
{
    NSParameterAssert(block != nil);
    
    NSArray *result = [self hj_mapIndex:^id(id obj, NSUInteger idx) {
        return block(obj);
    }];
    
    return result;
}

- (NSArray *)hj_mapIndex:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx))block
{
    NSParameterAssert(block != nil);
    
    if (![self isKindOfClass:NSArray.class] || self.count == 0) {
        return self;
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = block(obj, idx);
        if (value) {
            [result addObject:value];
        }
    }];
    
    return [result copy];
}

- (NSArray *)hj_flatMap:(id (NS_NOESCAPE ^)(id obj))block {
    NSParameterAssert(block != nil);
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = block(obj);
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray *arr = [value hj_flatMap:block];
            [result addObjectsFromArray:arr];
        } else if(value != nil) {
            [result addObject:value];
        }
    }];
    return [result copy];
}

- (NSArray *)hj_distinct {
    NSString *keyPath = [NSString stringWithFormat:@"@distinctUnionOfObjects.%@", @"self"];
    NSArray *uniqueResult = [self valueForKeyPath:keyPath];
    return uniqueResult;
}

- (id)hj_reduce:(id)initial withBlock:(id (^)(id sum, id obj))block
{
    NSParameterAssert(block != nil);
    
    __block id result = initial;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        result = block(result, obj);
    }];
    
    return result;
}

- (BOOL)hj_any:(BOOL (NS_NOESCAPE ^)(id obj))block
{
    return [self hj_match:block] != nil;
}

- (BOOL)hj_none:(BOOL (NS_NOESCAPE ^)(id obj))block
{
    return [self hj_match:block] == nil;
}

- (BOOL)hj_all:(BOOL (NS_NOESCAPE ^)(id obj))block
{
    NSParameterAssert(block != nil);
    
    __block BOOL result = YES;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (!block(obj)) {
            result = NO;
            *stop = YES;
        }
    }];
    
    return result;
}
@end
