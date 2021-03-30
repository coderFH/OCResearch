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
}

#pragma mark ----- 1.关于执行顺序的面试题 -----
//总结:使用sync函数往'当前串行队列'中添加任务，会卡住当前的串行队列（产生死锁）好好体会这句话

/*
 问题：以下代码是在主线程执行的，会不会产生死锁？
 会
 因为把任务2添加到主队列中,队列的执行顺序是先进先出,此时,队列里有一个viewDidLoad(或者interView01)的任务
 而dispatch_sync是立马在当前线程同步执行任务
 但任务2是在viewDidLoad这个任务后边的,所以viewdidload不执行完毕,永远不会执行任务2
 所以就造成了死锁,相互等待
 */
- (IBAction)interView01 {
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
 dispatch_async不要求立马在当前线程同步执行任务 1,3,2
 */
- (IBAction)interview02 {
    NSLog(@"执行任务1");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
    });
    
    NSLog(@"执行任务3");
}


/*
 问题：以下代码是在主线程执行的，会不会产生死锁？会！
 因为是串行任务,任务2和任务3又是同步执行,还是会形成一个互相等待的情况
 注意区分:"同步函数+串行队列: 不会开线程,任务串行执行
         "同步函数+串行队列" 不会死锁是因为 "主队列和串行队列", 他们不会互相等待
        而例子中的任务2和任务3都是在同一个串行队列中,2和3形成了相互等待
 */
- (IBAction)interview03 {
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
 虽然是串行队列,但两个任务是在不同的队列中,并不会互相等待 1 5 2 3 4
 */
- (IBAction)interview04 {
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
 因为是并发队列 1 5 2 3 4
 */
- (IBAction)interview05 {
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

#pragma mark ----- 2.关于performSelector的面试题 -----
- (IBAction)interview06 {
    NSLog(@"interview06");
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        NSLog(@"1");
        
        // performSelector:withObject:afterDelay这句代码的本质是往Runloop中添加定时器,而子线程默认没有启动Runloop
        // 之所以没有调用test的方法,就是因为这个线程开启后,是没有runloop的
        // 所以需要添加到runloop中
        [self performSelector:@selector(test) withObject:nil afterDelay:.0];
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
        //这个方法的本质就是一个消息方法,跟Runloop没有关系
//        [self performSelector:@selector(test) withObject:nil];
        
        NSLog(@"3");
    });
}

- (IBAction)interview07 {
    NSLog(@"interview07");
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
        
        //这句话的作用是保证runloop中有东西
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
    [thread start];
    
    /*
     考虑,如果我用一个强指针指向这个thread,是不是一样可以保着线程的命?
         其实把线程添加到runloop准确的说法应该是保证线程处于激活状态
         虽然你使用强指针指着这个thread,保证的命还在,但是在执行了一次之后,该线程的任务就已经结束了,所以当你再次调用,其实是没有效果的,虽然还在内存中,但他该做的事已经做完了
        所以需要把改thread添加到runloop中,使其一直处于激活的状态
     */
    
    //如果上述线程不添加到runloop中,程序会崩溃,因为线程在执行完block后,就退出了,利用runloop使他不能退出
    [self performSelector:@selector(test) onThread:thread withObject:nil waitUntilDone:YES];
}

- (void)test {
    NSLog(@"2");
}

@end
