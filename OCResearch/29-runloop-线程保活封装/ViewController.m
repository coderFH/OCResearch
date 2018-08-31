//
//  ViewController.m
//  29-runloop-线程保活封装
//
//  Created by wangfh on 2018/8/27.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHPermenantThread.h"

@interface ViewController ()

@property (strong, nonatomic) FHPermenantThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thread = [[FHPermenantThread alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.thread executeTask:^{
        NSLog(@"执行任务 - %@", [NSThread currentThread]);
    }];
}

- (IBAction)stop {
    [self.thread stop];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
