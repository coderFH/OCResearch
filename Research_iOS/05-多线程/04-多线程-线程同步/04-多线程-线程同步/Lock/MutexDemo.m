//
//  MutexDemo.m
//  32-多线程-线程同步
//
//  Created by wangfh on 2018/8/30.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "MutexDemo.h"
#import <pthread.h>

@interface MutexDemo()

@property (assign, nonatomic) pthread_mutex_t ticketMutex;
@property (assign, nonatomic) pthread_mutex_t moneyMutex;

@end

@implementation MutexDemo

- (instancetype)init {
    if (self = [super init]) {
        [self __initMutex:&_ticketMutex];
        [self __initMutex:&_moneyMutex];
    }
    return self;
}

- (void)__initMutex:(pthread_mutex_t *)mutex
{
    // 静态初始化
//            pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    
    //    // 初始化属性
    //    pthread_mutexattr_t attr;
    //    pthread_mutexattr_init(&attr);
    //    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    //    // 初始化锁
    //    pthread_mutex_init(mutex, &attr);
    //    // 销毁属性
    //    pthread_mutexattr_destroy(&attr);
    
    // 初始化锁 这里传NULL 就相当于37行属性传PTHREAD_MUTEX_DEFAULT
    pthread_mutex_init(mutex, NULL);
    
    // 销毁属性
    //    pthread_mutexattr_destroy(&attr);
}

- (void)__saleTicket {
    pthread_mutex_lock(&_ticketMutex);
    
    [super __saleTicket];
    
    pthread_mutex_unlock(&_ticketMutex);
}

- (void)__saveMoney {
    pthread_mutex_lock(&_moneyMutex);
    
    [super __saveMoney];
    
    pthread_mutex_unlock(&_moneyMutex);
}

- (void)__drawMoney {
    pthread_mutex_lock(&_moneyMutex);
    
    [super __drawMoney];
    
    pthread_mutex_unlock(&_moneyMutex);
}

// 记得销毁锁
- (void)dealloc {
    pthread_mutex_destroy(&_moneyMutex);
    pthread_mutex_destroy(&_ticketMutex);
}

@end
