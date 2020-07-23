//
//  SynchronizedDemo.m
//  32-多线程-线程同步
//
//  Created by wangfh on 2018/8/31.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "SynchronizedDemo.h"

@implementation SynchronizedDemo

- (void)__drawMoney {
    @synchronized([self class]) {
        [super __drawMoney];
    }
}

- (void)__saveMoney {
    //可以对类对象加锁,也可以直接对self加锁
    @synchronized([self class]) { // objc_sync_enter
        [super __saveMoney];
    } // objc_sync_exit
}

- (void)__saleTicket {
    //也可以通过这种方式加锁
    static NSObject *lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = [[NSObject alloc] init];
    });
    
    @synchronized(lock) {
        [super __saleTicket];
    }
}

//递归锁的演示
- (void)otherTest {
    @synchronized([self class]) {
        NSLog(@"123");
        [self otherTest];
    }
}

@end
