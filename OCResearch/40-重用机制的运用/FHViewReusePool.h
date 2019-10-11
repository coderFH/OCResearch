//
//  FHViewReusePool.h
//  40-重用机制的运用
//
//  Created by wangfh on 2019/10/11.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 实现重用机制的类
@interface FHViewReusePool : NSObject

/// 从重用池中取出一个可重用的view
- (UIView *)dequeReusableView;

/// 向重用池中添加一个视图
- (void)addUsingView:(UIView *)view;

/// 重置方法,将当前使用中的视图移动到可重用队列中
- (void)reset;

@end

NS_ASSUME_NONNULL_END
