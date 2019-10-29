//
//  ViewController.m
//  25-runloop-使用
//
//  Created by wangfh on 2019/10/29.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //1.获得主线程对应的runloop
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    
    //2.获得当前线程对应的runloop
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    
    NSLog(@"主线程:%p-----当前线程:%p",mainRunLoop,currentRunLoop);
    
    //Core
    NSLog(@"Core:%p",CFRunLoopGetMain());
    NSLog(@"Core:%p",CFRunLoopGetCurrent());
    NSLog(@"Core:%p",mainRunLoop.getCFRunLoop);
    
    //runloop和线程的关系
    //一一对应,主线程的runloop已经创建,但是子线程的需要手动创建
    [[[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil] start];
    
}

//在runloop中有多个运行模式,但是runloop只能选择一种模式运行
//mode里面至少要有一个timer或者source
- (void)run {
    //如何创建子线程对应的runloop? currentRunloop懒加载的
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    NSLog(@"run---%@",[NSThread currentThread]);
}

@end
