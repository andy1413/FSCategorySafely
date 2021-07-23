//
//  NSArray+Safely.m
//  FSCategorySafely
//
//  Created by wangfangshuai on 2018/7/30.
//  Copyright 2021年 wangfangshuai. All rights reserved.
//

#import "NSArray+Safely.h"
#import "NSObject+Utility.h"

@implementation NSArray (Safely)

+ (void)load {
    NSArray *arr = @[@"1", @"2"];
    [arr FS_MethodSwizzle:@selector(objectAtIndex:) newSEL:@selector(FS_objectAtIndex:)];
    [arr FS_MethodSwizzle:@selector(objectAtIndexedSubscript:) newSEL:@selector(FS_objectAtIndexedSubscript:)];
}

/*
+ (instancetype)arrayWithObjects:(id)firstObj, ... {
    NSMutableArray *array = [NSMutableArray array];
    //VA_LIST 是在C语言中解决变参问题的一组宏
    va_list argList;
    
    if (firstObj) {
        [array addObject:firstObj];
        // VA_START宏，获取可变参数列表的第一个参数的地址,在这里是获取firstObj的内存地址,这时argList的指针 指向firstObj
        va_start(argList, firstObj);
        // 临时指针变量
        id temp;
        // VA_ARG宏，获取可变参数的当前参数，返回指定类型并将指针指向下一参数
        // 首先 argList的内存地址指向的fristObj将对应储存的值取出,如果不为nil则判断为真,将取出的值房在数组中, 并且将指针指向下一个参数,这样每次循环argList所代表的指针偏移量就不断下移直到取出nil
        while ((temp = va_arg(argList, id))) {
            [array addObject:temp];
        }
    }
    
    // 清空列表
    va_end(argList);
    if (self == [NSMutableArray class]) {
        return array;
    } else {
        NSArray *ar = [array copy];
        return ar;
    }
}
*/

+ (instancetype)arrayWithObjects:(const id [])objects count:(NSUInteger)cnt {
    NSMutableArray *mArray = [[NSMutableArray alloc] init];

    for (NSUInteger i = 0; i < cnt; i ++) {
        if (objects[i]) {
            [mArray addObject:objects[i]];
        } else {
            NSCAssert(0, @"❌❌❌❌❌❌:array初始化传了nil");
        }
    }

    return [[self alloc] initWithArray:mArray];
}

- (id)FS_objectAtIndex:(NSUInteger)index {
    if (self.count > index) {
        return [self FS_objectAtIndex:index];
    }
    
    NSCAssert(0, @"❌❌❌❌❌❌:objectAtIndex:越界了");
    
    return nil;
}

- (id)FS_objectAtIndexedSubscript:(NSUInteger)index {
    if (self.count > index) {
        return [self FS_objectAtIndexedSubscript:index];
    }
    
    NSCAssert(0, @"❌❌❌❌❌❌:objectAtIndexedSubscript:越界了");
    
    return nil;
}

@end

@implementation NSMutableArray (Safely)

+ (void)load {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    FS_MethodSwizzle(arr.class, @selector(addObject:), @selector(FS_addObject:));
    FS_MethodSwizzle(arr.class, @selector(removeObjectAtIndex:), @selector(FS_removeObjectAtIndex:));
    FS_MethodSwizzle(arr.class, @selector(insertObject:atIndex:), @selector(FS_insertObject:atIndex:));
}

- (void)FS_addObject:(id)object {
    if (object) {
        [self FS_addObject:object];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌addObject:参数不是对象或为nil");
    }
}

- (void)FS_removeObjectAtIndex:(NSUInteger)index {
    if (self.count > index) {
        [self FS_removeObjectAtIndex:index];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌removeObjectAtIndex:参数越界");
    }
}

- (void)FS_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject) {
        NSUInteger count = self.count;
        if (count >= index) {
            [self FS_insertObject:anObject atIndex:index];
        } else {
            NSCAssert(0, @"❌❌❌❌❌❌insertObject:atIndex: index越界了,但是被我加到数组最后一位了");
            [self FS_insertObject:anObject atIndex:count];
        }
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌insertObject:atIndex:  Object不是合法对象");
    }
}

@end
