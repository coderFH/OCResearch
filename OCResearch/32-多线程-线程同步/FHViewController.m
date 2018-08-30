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
//=====================NSCondition下存取钱,卖票的演示=====================
- (IBAction)test8:(id)sender {
    FHOSSpinLockDemo *demo = [[FHOSSpinLockDemo alloc] init];
    [demo ticketTest];
    [demo moneyTest];
}



@end
