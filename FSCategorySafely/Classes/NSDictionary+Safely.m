//
//  NSDictionary+Safely.m
//  FSCategorySafely
//
//  Created by wangfangshuai on 2018/7/30.
//  Copyright 2021年 wangfangshuai. All rights reserved.
//

#import "NSDictionary+Safely.h"
#import "NSObject+Utility.h"

@implementation NSDictionary (Safely)

+ (instancetype)dictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt
{
    NSMutableArray *values = [NSMutableArray array];
    NSMutableArray *keyArr = [NSMutableArray array];
    
    for (int i = 0 ; i < cnt; i++) {
        id value = objects[i];
        id key = keys[i];
        if (value && key) {
            [values addObject:value];
            [keyArr addObject:key];
        } else {
            if (key) {
                NSLog(@"❌❌❌❌❌❌ Dictionary初始化'%@'对应的value为nil",key);
            } else {
                NSLog(@"❌❌❌❌❌❌ Dictionary初始化%@对应的key为nil",value);
            }
        }
    }
    
    // 用下面的方法构造
    return [self dictionaryWithObjects:values forKeys:keyArr];
}

@end


@implementation NSMutableDictionary (Safely)

+ (void)load {
    NSObject *obj = [[self alloc] init];
    [obj FS_MethodSwizzle:@selector(setObject:forKey:) newSEL:@selector(FS_setObject:forKey:)];
    [obj FS_MethodSwizzle:@selector(setObject:forKeyedSubscript:) newSEL:@selector(FS_setObject:forKeyedSubscript:)];
}

- (void)FS_setObject:(id)anObject forKey:(id)key {
    if (anObject && key) {
        [self FS_setObject:anObject forKey:key];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌ setObject:forKey: 参数有误");
    }
}

- (void)FS_setObject:(nullable id)anObject forKeyedSubscript:(id<NSCopying>)key {
    if (key) {
        [self FS_setObject:anObject forKeyedSubscript:key];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌ setObject:forKeyedSubscript: 参数有误");
    }
}

@end
