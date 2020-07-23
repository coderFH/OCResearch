//
//  NSLockDemo.m
//  32-多线程-线程同步
//
//  Created by wangfh on 2018/8/30.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "NSLockDemo.h"

@interface NSLockDemo()

@property (strong, nonatomic) NSLock *ticketLock;
@property (strong, nonatomic) NSLock *moneyLock;

@end

@implementation NSLockDemo

- (instancetype)init {
    if (self = [super init]) {
        self.ticketLock = [[NSLock alloc] init];
        self.moneyLock = [[NSLock alloc] init];
    }
    return self;
}

- (void)__saleTicket {
    [self.ticketLock lock];
    
    [super __saleTicket];
    
    [self.ticketLock unlock];
}

- (void)__saveMoney {
    [self.moneyLock lock];
    
    [super __saveMoney];
    
    [self.moneyLock unlock];
}

- (void)__drawMoney {
    [self.moneyLock lock];
    
    [super __drawMoney];
    
    [self.moneyLock unlock];
}

@end
