//
//  FHPermenantThread.h
//  29-runloop-线程保活封装
//
//  Created by wangfh on 2018/8/27.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FHPermenantThreadTask)(void);

@interface FHPermenantThread : NSObject

/**
 开启线程
 */
//- (void)run;

/**
 在当前子线程执行一个任务
 */
- (void)executeTask:(FHPermenantThreadTask)task;

/**
 结束线程
 */
- (void)stop;

@end
