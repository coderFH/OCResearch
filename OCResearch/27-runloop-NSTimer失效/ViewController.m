//
//  ViewController.m
//  27-runloop-NSTimer失效
//
//  Created by wangfh on 2018/8/27.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) dispatch_source_t timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self runloopAndGcd];
}

#pragma mark ----- timer失效 -----
- (void)timerInterval {
    static int count = 0;
    //这种方式添加的timer 在拖动textview的时候,定时器就失效了,因为定时器默认是添加在default模式下的
    //    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        NSLog(@"%d", ++count);
    //    }];
        
        //想解决以上问题,就把timer加入到runloop种,并且设定两种模式
        //1.创建定时器
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"%d", ++count);
        }];
        
        //2.添加定时器到runloop中,指定runloop的运行模式
        /*
         第一个参数:定时器
         第二个参数:runloop的运行模式
         */
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
        
        // NSDefaultRunLoopMode、UITrackingRunLoopMode才是真正存在的模式
        // NSRunLoopCommonModes并不是一个真的模式，它只是一个标记
        // timer能在_commonModes数组中存放的模式下工作
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark ----- GCD中的定时 -----
- (void)runloopAndGcd {
    //0.创建一个队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //1.创建一个GCD定时器
    /*
     第一个参数:说明这是一个定时器
        DISPATCH_SOURCE_TYPE_TIMER         定时响应（定时器事件）
        DISPATCH_SOURCE_TYPE_SIGNAL        接收到UNIX信号时响应
        DISPATCH_SOURCE_TYPE_READ          IO操作，如对文件的操作、socket操作的读响应
        DISPATCH_SOURCE_TYPE_WRITE         IO操作，如对文件的操作、socket操作的写响应
        DISPATCH_SOURCE_TYPE_VNODE         文件状态监听，文件被删除、移动、重命名
        DISPATCH_SOURCE_TYPE_PROC          进程监听,如进程的退出、创建一个或更多的子线程、进程收到UNIX信号
        下面两个都属于Mach相关事件响应
        DISPATCH_SOURCE_TYPE_MACH_SEND
        DISPATCH_SOURCE_TYPE_MACH_RECV
        下面两个都属于自定义的事件，并且也是有自己来触发
        DISPATCH_SOURCE_TYPE_DATA_ADD
        DISPATCH_SOURCE_TYPE_DATA_OR
     第四个参数：GCD的回调任务添加到那个队列中执行，如果是主队列则在主线程执行
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER
                                                     , 0, 0, queue);
    
    //2.设置定时器的开始时间,间隔时间以及精准度
    //设置开始时间,三秒后调用
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);
    //设置定时器工作的间隔时间
    uint64_t intervel = 1.0 * NSEC_PER_SEC;
    
    /*
     第一个参数：要给哪个定时器设置
     第二个参数：定时器的开始时间DISPATCH_TIME_NOW表示从当前开始
     第三个参数：定时器调用方法的间隔时间
     第四个参数：定时器的精准度，如果传0则表示采用最精准的方式计算，如果传大于0的数值，则表示该定时切换i可以接收该值范围内的误差，通常传0
     该参数的意义：可以适当的提高程序的性能
     注意点：GCD定时器中的时间以纳秒为单位（面试）
     */
    dispatch_source_set_timer(timer, start, intervel, 0 * NSEC_PER_SEC);

    //3.设置定时器开启后回调的方法
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"------%@",[NSThread currentThread]);
    });
    
    //4.执行定时器
    dispatch_resume(timer);
    
    //注意：dispatch_source_t本质上是OC类，在这里是个局部变量，需要强引用
    self.timer = timer;
}

@end
