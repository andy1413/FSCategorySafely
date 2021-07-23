//
//  NSObject+Utility.h
//  FSCategorySafely
//
//  Created by wangfangshuai on 2018/7/30.
//  Copyright 2021年 wangfangshuai. All rights reserved.
//  runtime方法交换的便捷接口

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// runtime MethodSwizzle
NS_INLINE void FS_MethodSwizzle(Class cls, SEL origSelector, SEL newSelector) {
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    BOOL didAddMethod = class_addMethod(cls,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


// Additional performSelector signatures that support up to 7 arguments.
@interface NSObject (Utility)

/**
 实例方法的MethodSwizzle

 @param origSelector 原方法 SEL
 @param newSelector 新方法 SEL
 */
- (void)FS_MethodSwizzle:(SEL)origSelector newSEL:(SEL)newSelector;

- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3;

- (id)performSelector:(SEL)selector
           withObject:(id)p1
           withObject:(id)p2
           withObject:(id)p3
           withObject:(id)p4;

- (id)performSelector:(SEL)selector
           withObject:(id)p1
           withObject:(id)p2
           withObject:(id)p3
           withObject:(id)p4
           withObject:(id)p5;

- (id)performSelector:(SEL)selector
           withObject:(id)p1
           withObject:(id)p2
           withObject:(id)p3
           withObject:(id)p4
           withObject:(id)p5
           withObject:(id)p6;

- (id)performSelector:(SEL)selector
           withObject:(id)p1
           withObject:(id)p2
           withObject:(id)p3
           withObject:(id)p4
           withObject:(id)p5
           withObject:(id)p6
           withObject:(id)p7;

@end
