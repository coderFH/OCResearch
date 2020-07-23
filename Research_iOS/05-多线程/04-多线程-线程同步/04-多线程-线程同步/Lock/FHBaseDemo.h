//
//  FHBaseDemo.h
//  32-多线程-线程同步
//
//  Created by wangfh on 2018/8/30.
//  Copyright © 2018年 wangfh. All rights reserved.
//  一个卖票和存取钱的演示,此时并没有加锁,运行后可以看到多线程下资源共享是有问题的

#import <Foundation/Foundation.h>

@interface FHBaseDemo : NSObject

- (void)moneyTest;
- (void)ticketTest;

#pragma mark - 暴露给子类去使用
- (void)__saveMoney;
- (void)__drawMoney;
- (void)__saleTicket;

@end
