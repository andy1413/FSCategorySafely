//
//  NSString+Safely.m
//  FSCategorySafely
//
//  Created by wangfangshuai on 2018/7/30.
//  Copyright 2021年 wangfangshuai. All rights reserved.
//

#import "NSString+Safely.h"
#import "NSObject+Utility.h"

@implementation NSString (Safely)

+ (void)load {
    NSObject *obj = [[self alloc] init];
    [obj FS_MethodSwizzle:@selector(stringByReplacingCharactersInRange:withString:) newSEL:@selector(FS_stringByReplacingCharactersInRange:withString:)];

    [obj FS_MethodSwizzle:@selector(stringByAppendingString:) newSEL:@selector(FS_stringByAppendingString:)];
    [obj FS_MethodSwizzle:@selector(stringByAppendingPathExtension:) newSEL:@selector(FS_stringByAppendingPathExtension:)];
    [obj FS_MethodSwizzle:@selector(characterAtIndex:) newSEL:@selector(FS_characterAtIndex:)];
    [obj FS_MethodSwizzle:@selector(substringFromIndex:) newSEL:@selector(FS_substringFromIndex:)];
    [obj FS_MethodSwizzle:@selector(substringToIndex:) newSEL:@selector(FS_substringToIndex:)];
    [obj FS_MethodSwizzle:@selector(substringWithRange:) newSEL:@selector(FS_substringWithRange:)];
    [obj FS_MethodSwizzle:@selector(getCharacters:range:) newSEL:@selector(FS_getCharacters:range:)];
}


- (NSString *)FS_stringByAppendingPathExtension:(NSString *)str {
    if (str) {
        return [self FS_stringByAppendingPathExtension:str];
    }
    
    NSCAssert(0, @"❌❌❌❌❌❌ stringByAppendingPathExtension: 参数为空或者为nil");
    return self;
}

- (NSString *)FS_stringByAppendingString:(NSString *)aString {
    if (aString) {
        return [self FS_stringByAppendingString:aString];
    }
    
    NSCAssert(0, @"❌❌❌❌❌❌ stringByAppendingString: 参数为空或者为nil");
    
    return self;
}

- (NSString *)FS_substringFromIndex:(NSUInteger)from {
    if (self.length > from) {
        return [self FS_substringFromIndex:from];
    }
    NSCAssert(0, @"❌❌❌❌❌❌ substringFromIndex: 越界了");
    return @"";
}

- (NSString *)FS_substringToIndex:(NSUInteger)to {
    if (self.length >= to) {
        return [self FS_substringToIndex:to];
    }
    NSCAssert(0, @"❌❌❌❌❌❌ substringToIndex: 越界了");
    return @"";
}

- (NSString *)FS_substringWithRange:(NSRange)range {
    if (self.length >= range.location + range.length) {
        return [self FS_substringWithRange:range];
    }
    NSCAssert(0, @"❌❌❌❌❌❌ substringWithRange: range越界了");
    return @"";
}

- (void)FS_getCharacters:(unichar *)buffer range:(NSRange)range {
    if (self.length >= range.location + range.length) {
        [self FS_getCharacters:buffer range:range];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌ getCharacters:range: range越界了");
    }
}

- (NSString *)FS_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    if (self.length >= range.location + range.length) {
        return [self FS_stringByReplacingCharactersInRange:range withString:replacement];
    }
    NSCAssert(0, @"❌❌❌❌❌❌ stringByReplacingCharactersInRange:withString: range越界了");
    return self;
}

- (unichar)FS_characterAtIndex:(NSUInteger)index {
    if (self.length > index) {
        return [self FS_characterAtIndex:index];
    }
    NSCAssert(0, @"❌❌❌❌❌❌ characterAtIndex: 越界了");
    return 0;
}

@end

@implementation NSMutableString (Safely)

+ (void)load {
    NSObject *obj = [[self alloc] init];
    [obj FS_MethodSwizzle:@selector(insertString:atIndex:) newSEL:@selector(FS_insertString:atIndex:)];
    [obj FS_MethodSwizzle:@selector(deleteCharactersInRange:) newSEL:@selector(FS_deleteCharactersInRange:)];
    
    [obj FS_MethodSwizzle:@selector(appendString:) newSEL:@selector(FS_appendString:)];
    
    [obj FS_MethodSwizzle:@selector(replaceCharactersInRange:withString:) newSEL:@selector(FS_replaceCharactersInRange:withString:)];
    [obj FS_MethodSwizzle:@selector(replaceCharactersInRange:withAttributedString:) newSEL:@selector(FS_replaceCharactersInRange:withAttributedString:)];
    
    [obj FS_MethodSwizzle:@selector(appendAttributedString:) newSEL:@selector(FS_appendAttributedString:)];
    [obj FS_MethodSwizzle:@selector(insertAttributedString:atIndex:) newSEL:@selector(FS_insertAttributedString:atIndex:)];
}

- (void)FS_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    if (aString && self.length >= loc) {
        [self FS_insertString:aString atIndex:loc];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌ insertString:atIndex: Index越界了, 但是被我插入到字符串末尾");
        [self FS_insertString:aString atIndex:self.length];
    }
}

- (void)FS_deleteCharactersInRange:(NSRange)range {
    if (self.length >= range.location + range.length) {
        [self FS_deleteCharactersInRange:range];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌ deleteCharactersInRange: range越界了");
    }
}

- (void)FS_appendString:(NSString *)aString {
    if (aString) {
        [self FS_appendString:aString];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌ appendString:  参数不能为nil");
    }
}

- (void)FS_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if (aString && self.length >= range.location + range.length) {
        [self FS_replaceCharactersInRange:range withString:aString];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌ appendString:  参数不能为nil");
    }
}

- (void)FS_replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString {
    if (!attrString) {
        NSCAssert(0, @"❌❌❌❌❌❌ replaceCharactersInRange:withAttributedString:  string参数不能为nil");
        return;
    }
    
    if (self.length < range.location + range.length) {
        NSCAssert(0, @"❌❌❌❌❌❌ replaceCharactersInRange:withAttributedString:  range越界");
        return;
    }
    
    [self FS_replaceCharactersInRange:range withAttributedString:attrString];
}

- (void)FS_insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc {
    if (!attrString) {
        NSCAssert(0, @"❌❌❌❌❌❌ insertAttributedString:atIndex:  string参数不能为nil");
        return;
    }
    
    if (self.length >= loc) {
        [self FS_insertAttributedString:attrString atIndex:loc];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌ insertAttributedString:atIndex:  index越界了, 但是被我插入到字符串末尾");
        [self FS_insertAttributedString:attrString atIndex:self.length];
    }
}

- (void)FS_appendAttributedString:(NSAttributedString *)attrString {
    if ([attrString respondsToSelector:@selector(string)]) {
        [self FS_appendAttributedString:attrString];
    } else {
        NSCAssert(0, @"❌❌❌❌❌❌ appendAttributedString: string参数异常");
    }
}

@end
