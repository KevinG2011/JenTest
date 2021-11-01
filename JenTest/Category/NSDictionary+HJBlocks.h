//
//  NSDictionary+HJBlocks.h
//  living
//
//  Created by lijia on 2018/9/4.
//  Copyright © 2018年 MJHF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary<KeyType, ObjectType> (HJBlocks)
- (void)hj_each:(void (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
- (void)hj_apply:(void (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
- (id)hj_match:(BOOL (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
- (NSDictionary *)hj_select:(BOOL (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
- (NSDictionary *)hj_reject:(BOOL (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
- (NSDictionary *)hj_map:(id (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
- (NSArray *)hj_listMap:(id (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
- (BOOL)hj_any:(BOOL (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
- (BOOL)hj_none:(BOOL (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
- (BOOL)hj_all:(BOOL (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
@end
