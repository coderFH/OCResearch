//
//  BaseObjectA.h
//  42-适配器模式
//
//  Created by wangfh on 2019/10/14.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObjectB.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseObjectA : NSObject

// 桥接模式的核心实现
@property(nonatomic, strong) BaseObjectB *objB;

// 获取数据
- (void)handle;

@end

NS_ASSUME_NONNULL_END
