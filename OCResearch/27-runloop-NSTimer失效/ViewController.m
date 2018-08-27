//
//  ViewController.m
//  27-runloop-NSTimer失效
//
//  Created by wangfh on 2018/8/27.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    static int count = 0;
    
    //这种方式添加的timer 在拖动textview的时候,定时器就失效了,因为定时器是添加在default模式下的
//    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"%d", ++count);
//    }];
    
    //想解决以上问题,就把timer加入到runloop种,并且设定两种模式
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%d", ++count);
    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    // NSDefaultRunLoopMode、UITrackingRunLoopMode才是真正存在的模式
    // NSRunLoopCommonModes并不是一个真的模式，它只是一个标记
    // timer能在_commonModes数组中存放的模式下工作
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (IBAction)stop:(id)sender {
}
- (IBAction)stop:(id)sender {
}
- (IBAction)stop:(id)sender {
}
- (IBAction)stopThread:(id)sender {
}


@end
