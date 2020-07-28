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
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE); // 属性改为递归锁
    // 初始化锁
    pthread_mutex_init(mutex, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
}

- (void)otherTest {
    /*
     既然使用递归锁可以重复加锁?那我多个线程访问的时候,不也重复加锁了,这不失去了锁的意义了吗?
     因为递归锁,只允许同一个线程对一把锁进行重复加锁
     而默认的锁,默认只能加一次锁,不管你是不是同一个线程
     */
    pthread_mutex_lock(&_mutex);
    
    NSLog(@"%s", __func__);
    
    static int count = 0;
    if (count < 10) {
        count++;
        [self otherTest]; // 因为是递归调用,再次调用otherTest时,发现加锁了,如果不是递归锁,会产生死锁(因为我锁并没有解,而发现已经加锁了),而如果是递归锁,就不会产生这个问题,因为递归锁可以重复加锁
    }
    
    pthread_mutex_unlock(&_mutex);
}

- (void)dealloc {
    pthread_mutex_destroy(&_mutex);
}

@end
