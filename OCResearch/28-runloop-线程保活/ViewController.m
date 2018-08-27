//
//  ViewController.m
//  28-runloop-线程保活
//
//  Created by wangfh on 2018/8/27.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHThread.h"

@interface ViewController ()

@property (strong, nonatomic) FHThread *thread;
@property (assign, nonatomic, getter=isStoped) BOOL stopped;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    self.stopped = NO;
    self.thread = [[FHThread alloc] initWithBlock:^{
        NSLog(@"%@----begin----", [NSThread currentThread]);
        
        // 往RunLoop里面添加Source\Timer\Observer
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        
        while (weakSelf && !weakSelf.isStoped) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
        NSLog(@"%@----end----", [NSThread currentThread]);
    }];
    [self.thread start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.thread) return;
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

// 子线程需要执行的任务
- (void)test
{
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
}

- (IBAction)stop {
    if (!self.thread) return;
    
    // 在子线程调用stop（waitUntilDone设置为YES，代表子线程的代码执行完毕后，这个方法才会往下走）
    [self performSelector:@selector(stopThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}

// 用于停止子线程的RunLoop
- (void)stopThread
{
    // 设置标记为YES
    self.stopped = YES;
    
    // 停止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
    
    // 清空线程
    self.thread = nil;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    
    [self stop];
}


@end
