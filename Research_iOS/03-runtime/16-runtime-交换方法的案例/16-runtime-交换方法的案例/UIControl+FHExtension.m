//
//  UIControl+FHExtension.m
//  25-runtime-交换方法的案例
//
//  Created by wangfh on 2018/8/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "UIControl+FHExtension.h"
#import <objc/runtime.h>

@implementation UIControl (FHExtension)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // hook：钩子函数
        Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        Method method2 = class_getInstanceMethod(self, @selector(fh_sendAction:to:forEvent:));
        method_exchangeImplementations(method1, method2);
    });
}

- (void)fh_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    NSLog(@"%@-%@-%@", self, target, NSStringFromSelector(action));
    
    // 调用系统原来的实现
    [self fh_sendAction:action to:target forEvent:event];
}

@end
