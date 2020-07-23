//
//  OSUnfairLockDemo.m
//  32-多线程-线程同步
//
//  Created by wangfh on 2018/8/30.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>

API_AVAILABLE(ios(10.0))
@interface OSUnfairLockDemo()

@property (assign, nonatomic) os_unfair_lock moneyLock;
@property (assign, nonatomic) os_unfair_lock ticketLock;

@end

@implementation OSUnfairLockDemo

- (instancetype)init {
    if (self = [super init]) {
        if (@available(iOS 10.0, *)) {
            self.moneyLock = OS_UNFAIR_LOCK_INIT;
        }
        if (@available(iOS 10.0, *)) {
            self.ticketLock = OS_UNFAIR_LOCK_INIT;
        }
    }
    return self;
}

- (void)__saleTicket {
    if (@available(iOS 10.0, *)) {
        os_unfair_lock_lock(&_ticketLock);
    }
    
    [super __saleTicket];
    
    if (@available(iOS 10.0, *)) {
        os_unfair_lock_unlock(&_ticketLock);
    }
}

- (void)__saveMoney {
    if (@available(iOS 10.0, *)) {
        os_unfair_lock_lock(&_moneyLock);
    }
    
    [super __saveMoney];
    
    if (@available(iOS 10.0, *)) {
        os_unfair_lock_unlock(&_moneyLock);
    }
}

- (void)__drawMoney {
    if (@available(iOS 10.0, *)) {
        os_unfair_lock_lock(&_moneyLock);
    }
    
    [super __drawMoney];
    
    if (@available(iOS 10.0, *)) {
        os_unfair_lock_unlock(&_moneyLock);
    }
}

@end
