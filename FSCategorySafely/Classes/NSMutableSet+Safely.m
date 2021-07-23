//
//  NSMutableSet+Safely.m
//  FSCategorySafely
//
//  Created by wangfangshuai on 2018/7/30.
//  Copyright 2021年 wangfangshuai. All rights reserved.
//

#import "NSMutableSet+Safely.h"
#import "NSObject+Utility.h"

@implementation NSMutableSet (Safely)

+ (void)load {
    NSObject *obj = [[self alloc] init];
    [obj FS_MethodSwizzle:@selector(addObject:) newSEL:@selector(FS_addObject:)];
}

- (void)FS_addObject:(id)object {
    if (object) {
        [self FS_addObject:object];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌addObject:参数不是对象或为nil");
    }
}

@end
