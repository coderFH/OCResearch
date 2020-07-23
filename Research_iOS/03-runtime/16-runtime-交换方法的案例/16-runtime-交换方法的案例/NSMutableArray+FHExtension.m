//
//  NSMutableArray+FHExtension.m
//  25-runtime-交换方法的案例
//
//  Created by wangfh on 2018/8/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "NSMutableArray+FHExtension.h"
#import <objc/runtime.h>

@implementation NSMutableArray (FHExtension)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 类簇：NSString、NSArray、NSDictionary，真实类型是其他类型
        Class cls = NSClassFromString(@"__NSArrayM");
        Method method1 = class_getInstanceMethod(cls, @selector(insertObject:atIndex:));
        Method method2 = class_getInstanceMethod(cls, @selector(fh_insertObject:atIndex:));
        method_exchangeImplementations(method1, method2);
    });
}

- (void)fh_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject == nil) return;
    
    [self fh_insertObject:anObject atIndex:index];
}

@end
