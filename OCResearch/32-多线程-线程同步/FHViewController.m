//
//  FHViewController.m
//  32-多线程-线程同步
//
//  Created by wangfh on 2018/8/30.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHViewController.h"
#import "FHBaseDemo.h"
#import "FHOSSpinLockDemo.h"
#import "OSUnfairLockDemo.h"
#import "MutexDemo.h"
#import "MutexDemoDiGui.h"
#import "MutexDemoTiaoJian.h"
#import "NSLockDemo.h"
#import "NSConditionDemo.h"
#import "NSConditionLockDemo.h"
#import "SerialQueueDemo.h"
#import "SemaphoreDemo.h"
#import "SynchronizedDemo.h"

@interface FHViewController ()

@end

@implementation FHViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark --未加锁下存取钱,卖票的演示
//=====================未加锁下存取钱,卖票的演示=====================
- (IBAction)test1:(id)sender {
    FHBaseDemo *demo = [[FHBaseDemo alloc] init];
    [demo ticketTest];
    [demo moneyTest];
}

#pragma mark --OSSpinLock下存取钱,卖票的演示
//=====================OSSpinLock下存取钱,卖票的演示=====================
- (IBAction)test2:(id)sender {
    FHOSSpinLockDemo *demo = [[FHOSSpinLockDemo alloc] init];
    [demo ticketTest];
    [demo moneyTest];
}

#pragma mark --os_unfair_lock下存取钱,卖票的演示
//=====================os_unfair_lock下存取钱,卖票的演示=====================
- (IBAction)test3:(id)sender {
    OSUnfairLockDemo *demo = [[OSUnfairLockDemo alloc] init];
    [demo ticketTest];
    [demo moneyTest];
}

#pragma mark --pthread_mutex下存取钱,卖票的演示
//=====================pthread_mutex下存取钱,卖票的演示=====================
- (IBAction)test4:(id)sender {
    MutexDemo *demo = [[MutexDemo alloc] init];
    [demo ticketTest];
    [demo moneyTest];
}

#pragma mark --pthread_mutex递归锁
//=====================pthread_mutex递归锁=====================
- (IBAction)test5:(id)sender {
    MutexDemoDiGui *demo = [[MutexDemoDiGui alloc] init];
    [demo otherTest];
}

#pragma mark --pthread_mutex-条件
//=====================pthread_mutex-条件=====================
- (IBAction)test6:(id)sender {
    MutexDemoTiaoJian *demo = [[MutexDemoTiaoJian alloc] init];
    [demo otherTest];
}

#pragma mark --NSLock下存取钱,卖票的演示
//=====================NSLock下存取钱,卖票的演示=====================
- (IBAction)test7:(id)sender {
    NSLockDemo *demo = [[NSLockDemo alloc] init];
    [demo ticketTest];
    [demo moneyTest];
}

#pragma mark --NSCondition下存取钱,卖票的演示
//=====================NSCondition-条件(其实是对pthread_mutex的封装)=====================
- (IBAction)test8:(id)sender {
    NSConditionDemo *demo = [[NSConditionDemo alloc] init];
    [demo otherTest];
}

#pragma mark --NSConditionLock实现线程同步
//=====================NSConditionLock实现线程同步=====================
- (IBAction)test9:(id)sender {
    NSConditionLockDemo *demo = [[NSConditionLockDemo alloc] init];
    [demo otherTest];
}

#pragma mark --串行队列实现线程同步
//=====================串行队列实现线程同步=====================
- (IBAction)test10:(id)sender {
    SerialQueueDemo *demo = [[SerialQueueDemo alloc] init];
    [demo ticketTest];
    [demo moneyTest];
}

#pragma mark --信号量
//=====================信号量=====================
- (IBAction)test11:(id)sender {
    SemaphoreDemo *demo = [[SemaphoreDemo alloc] init];
    [demo otherTest];
//    [demo ticketTest];
//    [demo moneyTest];
}

#pragma mark --synchronized
//=====================Synchronized(本质是对pthread_mutex递归锁的封装)=====================
- (IBAction)test12:(id)sender {
    SynchronizedDemo *demo = [[SynchronizedDemo alloc] init];
//    [demo otherTest];
    [demo ticketTest];
    [demo moneyTest];
}

@end
