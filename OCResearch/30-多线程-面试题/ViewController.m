//
//  ViewController.m
//  30-多线程-面试题
//
//  Created by wangfh on 2018/8/29.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //查看队列的内存地址
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    
    /*
     获取全局并发队列
     第一个参数: DISPATCH_QUEUE_PRIORITY_DEFAULT  对应的值是0
     第二个参数: 永远传0
     */
    dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
    
    /*
     第一个参数:C语言字符串,标签
     第二个参数:DISPATCH_QUEUE_CONCURRENT 并发队列
              DISPATCH_QUEUE_SERIAL     串行队列
     */
    dispatch_queue_t queue3 = dispatch_queue_create("queu3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue4 = dispatch_queue_create("queu4", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue5 = dispatch_queue_create("queu5", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"%p %p %p %p %p", queue1, queue2, queue3, queue4, queue5);
    
    [self interview07];
}

//======================================关于performSelector的面试题======================================
- (void)interview06 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        NSLog(@"1");
        
        // 这句代码的本质是往Runloop中添加定时器
        //只所以没有调用test2的方法,就是因为这个线程开启后,是没有runloop的
        //所以需要添加到runloop中
        [self performSelector:@selector(test) withObject:nil afterDelay:.0];
        //[[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        //[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
        //这个方法的本质就是一个消息方法,跟Runloop没有关系
//        [self performSelector:<#(SEL)#> withObject:<#(id)#>]
        
        NSLog(@"3");
    });
}

- (void)test {
    NSLog(@"2");
}

- (void)interview07 {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
        
        //这句话的作用是保证runloop中有东西
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
    [thread start];
    
    //如果上述线程不添加到runloop中,程序会崩溃,因为线程在执行完block后,就退出了,利用runloop使他不能退出
    [self performSelector:@selector(test) onThread:thread withObject:nil waitUntilDone:YES];
}



//======================================关于执行顺序的面试题======================================
//总结:使用sync函数往'当前串行队列'中添加任务，会卡住当前的串行队列（产生死锁）

/*
 问题：以下代码是在主线程执行的，会不会产生死锁？
 会
 因为把任务2添加到主队列中,队列的执行顺序是先进先出,此时,队列里有一个viewDidLoad的任务
 而dispatch_sync是立马在当前线程同步执行任务
 但任务2是在viewDidLoad这个任务后边的,所以viewdidload不执行完毕,永远不会执行任务2
 所以就造成了死锁,相互等待
 */
- (void)interView01 {
    NSLog(@"执行任务1");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"执行任务2");
    });
    
    NSLog(@"执行任务3");
}

/*
 问题：以下代码是在主线程执行的，会不会产生死锁？
 不会！
 dispatch_async不要求立马在当前线程同步执行任务
 */
- (void)interview02 {
    NSLog(@"执行任务1");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
    });
    
    NSLog(@"执行任务3");
}


/*
 问题：以下代码是在主线程执行的，会不会产生死锁？不会！
 因为是串行任务,任务2和任务3又是同步执行,还是会形成一个互相等待的情况
 */
- (void)interview03 {
    NSLog(@"执行任务1");
    
    //创建一个串行的任务
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{ // 0
        NSLog(@"执行任务2");
        
        dispatch_sync(queue, ^{ // 1
            NSLog(@"执行任务3");
        });
        
        NSLog(@"执行任务4");
    });
    
    NSLog(@"执行任务5");
}

/*
 问题：以下代码是在主线程执行的，会不会产生死锁？不会！
 虽然是串行队列,但两个任务是在不同的队列中,并不会互相等待
 */
- (void)interview04 {
    NSLog(@"执行任务1");
    
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("myqueu2", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{ // 0
        NSLog(@"执行任务2");
        
        dispatch_sync(queue2, ^{ // 1
            NSLog(@"执行任务3");
        });
        
        NSLog(@"执行任务4");
    });
    
    NSLog(@"执行任务5");
}

/*
 问题：以下代码是在主线程执行的，会不会产生死锁？不会！
 因为是并发队列
 */
- (void)interview05 {
    NSLog(@"执行任务1");
    
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{ // 0
        NSLog(@"执行任务2");
        
        dispatch_sync(queue, ^{ // 1
            NSLog(@"执行任务3");
        });
        
        NSLog(@"执行任务4");
    });
    
    NSLog(@"执行任务5");
}

@end
