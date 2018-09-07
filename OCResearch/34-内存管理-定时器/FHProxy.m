//
//  FHProxy.m
//  34-内存管理-定时器
//
//  Created by wangfh on 2018/9/7.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHProxy.h"

@implementation FHProxy

+ (instancetype)proxyWithTarget:(id)target
{
    FHProxy *proxy = [[FHProxy alloc] init];
    proxy.target = target;
    return proxy;
}

//使用消息转发,当找不到方式时候,转发出去让控制器处理
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.target;
}

@end
