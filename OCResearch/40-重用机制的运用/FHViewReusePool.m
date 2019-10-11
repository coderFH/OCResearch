//
//  FHViewReusePool.m
//  40-重用机制的运用
//
//  Created by wangfh on 2019/10/11.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "FHViewReusePool.h"

@interface FHViewReusePool()

/// 等待使用的队列
@property(nonatomic, strong) NSMutableSet *waitUsedQueue;

/// 使用中的队列
@property(nonatomic, strong) NSMutableSet *usingQueue;

@end

@implementation FHViewReusePool

- (instancetype)init {
    self = [super init];
    if (self) {
        _waitUsedQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
}

- (UIView *)dequeReusableView {
    UIView *view = [_waitUsedQueue anyObject];
    if (view == nil) {
        return nil;
    } else {
        //进行队列移动
        [_waitUsedQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    }
}

- (void)addUsingView:(UIView *)view {
    if (view == nil) {
        return;
    }
    //添加视图到使用中的队列
    [_usingQueue addObject:view];
}

- (void)reset {
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {
        //从使用队列中移除
        [_usingQueue removeObject:view];
        //加入等待使用的duilie
        [_waitUsedQueue addObject:view];
    }
}

@end
