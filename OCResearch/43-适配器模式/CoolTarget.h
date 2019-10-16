//
//  CoolTarget.h
//  43-适配器模式
//
//  Created by wangfh on 2019/10/15.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "Target.h"

NS_ASSUME_NONNULL_BEGIN

// 适配对象
@interface CoolTarget : NSObject

// 被适配对象
@property(nonatomic, strong) Target *target;

// 对原有方法包装
- (void)request;

@end

NS_ASSUME_NONNULL_END
