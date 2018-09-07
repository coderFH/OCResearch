//
//  FHProxy1.m
//  34-内存管理-定时器
//
//  Created by wangfh on 2018/9/7.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHProxy1.h"

@implementation FHProxy1

+ (instancetype)proxyWithTarget:(id)target {
    // NSProxy对象不需要调用init，因为它本来就没有init方法
    FHProxy1 *proxy = [FHProxy1 alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
