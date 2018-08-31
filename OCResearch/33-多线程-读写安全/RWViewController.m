//
//  RWViewController.m
//  33-多线程-读写安全
//
//  Created by wangfh on 2018/8/31.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "RWViewController.h"
#import <pthread.h>

@interface RWViewController ()

@property (assign, nonatomic) pthread_rwlock_t lock;
@property (strong, nonatomic) dispatch_queue_t queue;

@end

@implementation RWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//===============================pthread_rwlock：读写锁==============================
- (IBAction)pthread_rwlock:(id)sender {
    // 初始化锁
    pthread_rwlock_init(&_lock, NULL);
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            [self read1];
        });
        dispatch_async(queue, ^{
            [self write1];
        });
    }
}

- (void)read1 {
    pthread_rwlock_rdlock(&_lock);
    
    sleep(1);
    NSLog(@"%s", __func__);
    
    pthread_rwlock_unlock(&_lock);
}

- (void)write1 {
    pthread_rwlock_wrlock(&_lock);
    
    sleep(1);
    NSLog(@"%s", __func__);
    
    pthread_rwlock_unlock(&_lock);
}

- (void)dealloc {
    pthread_rwlock_destroy(&_lock);
}

//===============================dispatch_barrier_async：异步栅栏调用===============================
- (IBAction)dispatch_barrier_async:(id)sender {
    self.queue = dispatch_queue_create("rw_queue", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(self.queue, ^{
            [self read];
        });
        
        dispatch_async(self.queue, ^{
            [self read];
        });
        
        dispatch_async(self.queue, ^{
            [self read];
        });
        
        dispatch_barrier_async(self.queue, ^{
            [self write];
        });
    }
    
}

- (void)read {
    sleep(1);
    NSLog(@"read");
}

- (void)write {
    sleep(1);
    NSLog(@"write");
}


@end
