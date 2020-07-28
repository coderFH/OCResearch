//
//  NSConditionDemo.m
//  32-多线程-线程同步
//
//  Created by wangfh on 2018/8/30.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "NSConditionDemo.h"

@interface NSConditionDemo()
@property (strong, nonatomic) NSCondition *condition;
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation NSConditionDemo

- (instancetype)init {
    if (self = [super init]) {
        self.condition = [[NSCondition alloc] init];
        self.data = [NSMutableArray array];
    }
    return self;
}

- (void)otherTest {
    [[[NSThread alloc] initWithTarget:self selector:@selector(__remove) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__add) object:nil] start];
}

// 生产者-消费者模式

// 线程1
// 删除数组中的元素
- (void)__remove{
    [self.condition lock];
    NSLog(@"__remove - begin");
    
    if (self.data.count == 0) {
        // 等待
        [self.condition wait];
    }
    
    [self.data removeLastObject];
    NSLog(@"删除了元素");
    
    [self.condition unlock];
}

// 线程2
// 往数组中添加元素
- (void)__add {
    [self.condition lock];
    
    sleep(1);
    
    [self.data addObject:@"Test"];
    NSLog(@"添加了元素");
    // 信号
    [self.condition signal]; // 他只是唤醒等待这个条件的线程,他一唤醒,41行会对当前锁进行加锁,因为60代码还没有往下执行,所以锁还没解开,导致41行会等待解锁后再继续执行下边的代码,其实也就是41行,不能马上的加锁成功
    
    // 广播
    //    [self.condition broadcast];
    [self.condition unlock];
}

@end
