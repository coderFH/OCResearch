//
//  FHOSSpinLockDemo.m
//  32-多线程-线程同步
//
//  Created by wangfh on 2018/8/30.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHOSSpinLockDemo.h"
#import <libkern/OSAtomic.h>

@interface FHOSSpinLockDemo()

@property (assign, nonatomic) OSSpinLock moneyLock;
@property (assign, nonatomic) OSSpinLock ticketLock;

@end

@implementation FHOSSpinLockDemo

- (instancetype)init {
    if (self = [super init]) {
        self.moneyLock = OS_SPINLOCK_INIT;
        self.ticketLock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (void)__drawMoney {
    OSSpinLockLock(&_moneyLock);
    
    [super __drawMoney];
    
    OSSpinLockUnlock(&_moneyLock);
}

- (void)__saveMoney {
    OSSpinLockLock(&_moneyLock);
    
    [super __saveMoney];
    
    OSSpinLockUnlock(&_moneyLock);
}

- (void)__saleTicket {
    OSSpinLockLock(&_ticketLock);
    
    [super __saleTicket];
    
    OSSpinLockUnlock(&_ticketLock);
}

@end
