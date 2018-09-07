//
//  ViewController.m
//  35-内存管理-GCD定时器的封装
//
//  Created by wangfh on 2018/9/7.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHTimer.h"

@interface ViewController ()

@property (strong, nonatomic) dispatch_source_t timer;
@property (copy, nonatomic) NSString *task;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 接口设计
    //1.Target Action方式:
    self.task = [FHTimer execTask:self
                         selector:@selector(doTask)
                            start:2.0
                         interval:1.0
                          repeats:YES
                            async:NO];
    
    //2.block方式
//    self.task = [FHTimer execTask:^{
//        NSLog(@"111111 - %@", [NSThread currentThread]);
//    } start:2.0 interval:-10 repeats:NO async:NO];
}


- (void)doTask {
    NSLog(@"doTask - %@", [NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [FHTimer cancelTask:self.task];
}

@end
