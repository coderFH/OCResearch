//
//  FHPerson.m
//  20-runtime-消息转发的应用
//
//  Created by wangfh on 2018/8/23.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHPerson.h"

@implementation FHPerson

- (void)run {
    NSLog(@"run-123");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    // 本来能调用的方法
    if ([self respondsToSelector:aSelector]) {
        return [super methodSignatureForSelector:aSelector];
    }
    // 找不到的方法
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

// 找不到的方法，都会来到这里,就可以收集找不到的方法,上传到公司服务器,去查找问题,或者可以写一个NSObject的分类,去收集找不到的方法
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"找不到%@方法", NSStringFromSelector(anInvocation.selector));
}

@end
