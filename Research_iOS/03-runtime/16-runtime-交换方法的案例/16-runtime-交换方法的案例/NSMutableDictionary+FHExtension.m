//
//  NSMutableDictionary+FHExtension.m
//  25-runtime-交换方法的案例
//
//  Created by wangfh on 2018/8/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "NSMutableDictionary+FHExtension.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (FHExtension)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"__NSDictionaryM");
        Method method1 = class_getInstanceMethod(cls, @selector(setObject:forKeyedSubscript:));
        Method method2 = class_getInstanceMethod(cls, @selector(fh_setObject:forKeyedSubscript:));
        method_exchangeImplementations(method1, method2);
        
        Class cls2 = NSClassFromString(@"__NSDictionaryI");
        Method method3 = class_getInstanceMethod(cls2, @selector(objectForKeyedSubscript:));
        Method method4 = class_getInstanceMethod(cls2, @selector(fh_objectForKeyedSubscript:));
        method_exchangeImplementations(method3, method4);
    });
}

- (void)fh_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (!key) return;
    
    [self fh_setObject:obj forKeyedSubscript:key];
}

- (id)fh_objectForKeyedSubscript:(id)key
{
    if (!key) return nil;
    
    return [self fh_objectForKeyedSubscript:key];
}

@end
