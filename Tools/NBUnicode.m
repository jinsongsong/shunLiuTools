//
//  NBUnicode.m
//  shunLiuTools
//
//  Created by shun on 2022/8/5.
//

#import "NBUnicode.h"
#import <objc/runtime.h>

static inline void NB_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSString (LYLUnicode)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (LYLUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        NB_swizzleSelector(class, @selector(description), @selector(NB_description));
        NB_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(NB_descriptionWithLocale:));
        NB_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(NB_descriptionWithLocale:indent:));
    });
}

/**
 *  我觉得
 *  可以把以下的方法放到一个NSObject的category中
 *  然后在需要的类中进行swizzle
 *  但是又觉得这样太粗暴了。。。。
 */

- (NSString *)NB_description {
    return [[self NB_description] stringByReplaceUnicode];
}

- (NSString *)NB_descriptionWithLocale:(nullable id)locale {
    return [[self NB_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)NB_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self NB_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (LYLUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        NB_swizzleSelector(class, @selector(description), @selector(NB_description));
        NB_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(NB_descriptionWithLocale:));
        NB_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(NB_descriptionWithLocale:indent:));
    });
}

- (NSString *)NB_description {
    return [[self NB_description] stringByReplaceUnicode];
}

- (NSString *)NB_descriptionWithLocale:(nullable id)locale {
    return [[self NB_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)NB_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self NB_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (LYLUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        NB_swizzleSelector(class, @selector(description), @selector(NB_description));
        NB_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(NB_descriptionWithLocale:));
        NB_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(NB_descriptionWithLocale:indent:));
    });
}

- (NSString *)NB_description {
    return [[self NB_description] stringByReplaceUnicode];
}

- (NSString *)NB_descriptionWithLocale:(nullable id)locale {
    return [[self NB_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)NB_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self NB_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end


