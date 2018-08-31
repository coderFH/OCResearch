//
//  NSConditionLockDemo.m
//  32-多线程-线程同步
//
//  Created by wangfh on 2018/8/31.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "NSConditionLockDemo.h"

@interface NSConditionLockDemo()
@property (strong, nonatomic) NSConditionLock *conditionLock;
@end

@implementation NSConditionLockDemo

- (instancetype)init {
    if (self = [super init]) {
        //这里虽然传的1  但32行的lock只是会看是否加锁,如果没加就加锁  lock不管条件值
        self.conditionLock = [[NSConditionLock alloc] initWithCondition:1];
    }
    return self;
}

- (void)otherTest {
    [[[NSThread alloc] initWithTarget:self selector:@selector(__one) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__two) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__three) object:nil] start];
}

- (void)__one {
    [self.conditionLock lock];
    
    NSLog(@"__one");
    sleep(1);
    
    [self.conditionLock unlockWithCondition:2];
}

- (void)__two {
    //等到条件值是2的时候再加锁
    [self.conditionLock lockWhenCondition:2];
    
    NSLog(@"__two");
    sleep(1);
    
    [self.conditionLock unlockWithCondition:3];
}

- (void)__three {
    //等到条件值是3的时候再加锁
    [self.conditionLock lockWhenCondition:3];
    
    NSLog(@"__three");
    
    [self.conditionLock unlock];
}

@end
