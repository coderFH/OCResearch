//
//  MutexDemoDiGui.m
//  32-多线程-线程同步
//
//  Created by wangfh on 2018/8/30.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "MutexDemoDiGui.h"
#import <pthread.h>

@interface MutexDemoDiGui()

@property (assign, nonatomic) pthread_mutex_t mutex;

@end

@implementation MutexDemoDiGui

- (instancetype)init {
    if (self = [super init]) {
        [self __initMutex:&_mutex];
    }
    return self;
}

- (void)__initMutex:(pthread_mutex_t *)mutex {
    // 递归锁：允许同一个线程对一把锁进行重复加锁
    
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    // 初始化锁
    pthread_mutex_init(mutex, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
}

- (void)otherTest {
    pthread_mutex_lock(&_mutex);
    
    NSLog(@"%s", __func__);
    
    static int count = 0;
    if (count < 10) {
        count++;
        [self otherTest];
    }
    
    pthread_mutex_unlock(&_mutex);
}

- (void)dealloc {
    pthread_mutex_destroy(&_mutex);
}

@end
