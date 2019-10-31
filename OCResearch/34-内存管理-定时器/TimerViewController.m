//
//  TimerViewController.m
//  34-内存管理-定时器
//
//  Created by wangfh on 2018/9/7.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "TimerViewController.h"
#import "FHProxy.h"
#import "FHProxy1.h"

@interface TimerViewController ()

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) NSTimer *timer;
@property (strong, nonatomic) dispatch_source_t disTimer;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //先来看一个问题:在使用NSTimer或者CADisplayLink的时候,会有什么问题??
    //答:可能会产循环引用的问题
//    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTest)];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
    //上边两行代码执行后,可以看到返回的时候并没有调用delloc方法,说明产生了相互吸引
    //控制器拥有Timer对象或者link对象,而这两个对象中的target又引用控制器,就形成了相互引用
    
    //如何解决上边循环利用的问题
    //方式1:通过block
//    __weak typeof(self) weakSelf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [weakSelf timerTest];
//    }];
    
    //方式2:通过一个中间对象,去读持有的控制器做一个弱引用
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[FHProxy proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
    //上边的FHProxy是继承自NSObject类的,但苹果专门出了一个类,去处理这种消息转发的类NSProxy
    
    //我们让FHProxy1继承NSProxy
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[FHProxy1 proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
    //其实继承NSProxy,更加好,因为这个类就是苹果提供给我们专门做消息转发的类
//    TimerViewController *vc = [[TimerViewController alloc] init];
//    FHProxy *proxy = [FHProxy proxyWithTarget:vc];
//    FHProxy1 *proxy1 = [FHProxy1 proxyWithTarget:vc];
//    NSLog(@"%d",[proxy isKindOfClass:[UIViewController class]]);//0
//    NSLog(@"%d",[proxy1 isKindOfClass:[UIViewController class]]);//1
    //通过上边0,1的打印,也可以看出区别,继承自NSProxy的也可以转发vc的isKindofClass方法,所以我们完全可以拿proxy1当vc去用,很完美
    
    //注意:link和timer其实都是添加到runloop中,所以时间并不会非常准确,因为runloop是一直循环做事情,比如runloop跑一圈需要0.04秒
    //我们现在有个1秒触发的任务 这样runloop跑了两次后是0.08秒,不够一秒,它会再跑一圈,而这时已经是1.02秒了
    //所以利用runloop去做定时操作,时间是不准确的
    //如何去解决计时不准的问题?可以使用GCD
    [self GCD];
}



- (void)timerTest {
    NSLog(@"%s", __func__);
}

- (void)linkTest {
    NSLog(@"%s", __func__);
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self.link invalidate];
    [self.timer invalidate];
}

- (void)GCD {
    // 队列,创建不同的队列,可以控制计时在哪个线程处理
    // dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_queue_t queue = dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL);
    
    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置时间
    uint64_t start = 2.0; // 2秒后开始执行
    uint64_t interval = 1.0; // 每隔1秒执行
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC),
                              interval * NSEC_PER_SEC, 0);
    
    // 设置回调
    //    dispatch_source_set_event_handler(timer, ^{
    //        NSLog(@"1111");
    //    });
    dispatch_source_set_event_handler_f(timer, timerFire);
    
    // 启动定时器
    dispatch_resume(timer);
    self.disTimer = timer;
}

void timerFire(void *param) {
    NSLog(@"2222 - %@", [NSThread currentThread]);
}

@end
