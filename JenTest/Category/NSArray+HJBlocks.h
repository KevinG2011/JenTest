//
//  NSArray+HJBlocks.h
//  living
//
//  Created by lijia on 2018/9/4.
//  Copyright © 2018年 MJHF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (HJBlocks)
- (void)hj_each:(void (NS_NOESCAPE ^)(ObjectType obj))block;
- (void)hj_apply:(void (NS_NOESCAPE ^)(ObjectType obj))block;
- (id)hj_match:(BOOL (NS_NOESCAPE ^)(ObjectType obj))block;
- (NSArray *)hj_select:(BOOL (NS_NOESCAPE ^)(ObjectType obj))block;
- (NSArray *)hj_reject:(BOOL (NS_NOESCAPE ^)(ObjectType obj))block;
- (NSArray *)hj_map:(id (NS_NOESCAPE ^)(ObjectType obj))block;
- (NSArray *)hj_mapIndex:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx))block;
- (NSArray *)hj_flatMap:(id (NS_NOESCAPE ^)(ObjectType obj))block;
- (NSArray *)hj_distinct;
- (BOOL)hj_any:(BOOL (NS_NOESCAPE ^)(ObjectType obj))block;
- (BOOL)hj_none:(BOOL (NS_NOESCAPE ^)(ObjectType obj))block;
- (BOOL)hj_all:(BOOL (NS_NOESCAPE ^)(ObjectType obj))block;
@end
