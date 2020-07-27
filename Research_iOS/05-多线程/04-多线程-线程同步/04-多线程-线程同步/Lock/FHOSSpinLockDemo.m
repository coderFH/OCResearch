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

/*
 1. OSSpinLock:是一种自旋锁,就是没到你执行的时候,你是处于忙等状态,而非休眠状态
 2. CPU时间片轮转调度算法,给每个线程都分配一定的时间去执行,观感上就想很多个任务在同时执行一样
 3. OSSpinLock的劣势? 可能会出现优先级反转的问题
 4. 为什么会出现优先级反转的问题? 如果等待锁的优先级比较高,他会一直占用CPU资源,优先级低的线程就无法释放锁
    假设有2个线程 thread1: 优先级比较高
                thread2: 优先级比较低
         比如2线程先进入,发现未加锁,就加锁, 然后线程1进来,发现锁已加,就只能忙等 相当于一只在执行while(未解锁) 忙等
         又因为1的优先级比较高,所以CPU有可能就一直分配时间给线程1, 而线程1 又一直在忙等,有可能cpu就没有给线程2分配时间,线程2就没法往下走,最终导致放不开这把锁,就是因为你自旋的过程中也是占资源的
         而如果是睡眠的锁,cpu发现你在休眠,就不会把资源分配给你,这样线程2就能继续往下走,然后就能解开这把锁,所以自旋锁相对于休眠锁就有这点劣势
 */
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
