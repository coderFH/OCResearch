//
//  MutexDemoTiaoJian.m
//  32-多线程-线程同步
//
//  Created by wangfh on 2018/8/30.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "MutexDemoTiaoJian.h"
#import <pthread.h>

@interface MutexDemoTiaoJian()

@property (assign, nonatomic) pthread_mutex_t mutex;
@property (assign, nonatomic) pthread_cond_t cond;
@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation MutexDemoTiaoJian

- (instancetype)init {
    if (self = [super init]) {
        // 初始化属性
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        // 初始化锁
        pthread_mutex_init(&_mutex, &attr);
        // 销毁属性
        pthread_mutexattr_destroy(&attr);
        
        // 初始化条件
        pthread_cond_init(&_cond, NULL);
        
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
- (void)__remove {
    pthread_mutex_lock(&_mutex);
    NSLog(@"__remove - begin");
    
    if (self.data.count == 0) {
        // 等待 它会让线程先睡眠,并且解锁,当收到唤醒的消息的时候,会加锁,并继续往下执行
        //1.他会解锁
        //2.他会等待
        //3.传入的条件是给别人唤醒的
        pthread_cond_wait(&_cond, &_mutex);
    }
    
    [self.data removeLastObject];
    NSLog(@"删除了元素");
    
    pthread_mutex_unlock(&_mutex);
}

// 线程2
// 往数组中添加元素
- (void)__add {
    pthread_mutex_lock(&_mutex);
    
    sleep(1);
    
    [self.data addObject:@"Test"];
    NSLog(@"添加了元素");
    
    // 信号,通知告诉说数组有东西了
    pthread_cond_signal(&_cond);
    
    // 广播  通知所有睡眠的线程,并且加锁
    //    pthread_cond_broadcast(&_cond);
    
    pthread_mutex_unlock(&_mutex);
}

- (void)dealloc {
    pthread_mutex_destroy(&_mutex);
    pthread_cond_destroy(&_cond);
}

@end
