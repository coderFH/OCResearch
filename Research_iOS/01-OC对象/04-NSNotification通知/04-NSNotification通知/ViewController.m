//
//  ViewController.m
//  04-NSNotification通知
//
//  Created by wangfh on 2019/11/27.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "ViewController.h"

/*
 NSNotification是同步还是异步的?
 默认在主线程中,当通知产生时,通知中心会一直等待所有的观察者都收到并且处理完之后,才会返回发送通知的地方继续执行后面的代码
 所以将发送通知放到子线程中
 NSNotificationQueue是一个通知缓冲队列
 */

#define MyNotificationTestName @"NSNotificatonTestName"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(process) name:MyNotificationTestName object:nil];
        
    NSLog(@"即将发送通知");
    
    //1.默认是在主线程中,并且会等待所有监听着完成操作后,再执行后续代码
//    [[NSNotificationCenter defaultCenter] postNotificationName:MyNotificationTestName object:nil];
        
    //2.将发送通知的方法,放到子线程,这样process方法默认就在子线程中去处理操作
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:MyNotificationTestName object:nil];
//        });
        
    
    //3.通过NSNotificationQueue的方式,但process方法还是在主线程中,可以在方法里边去开子线程处理
    //NSPostASAP:尽快发送
    //NSPostWhenIdle:空闲时发送
    //NSPostNow:现在立刻发送
    NSNotification *notification = [NSNotification notificationWithName:MyNotificationTestName object:nil];
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostASAP];
    NSLog(@"发出通知的下一条代码,观察是否阻塞");
}

- (void)process {
    sleep(10);
    NSLog(@"通知处理结束 %@",[NSThread currentThread]);
}

@end

