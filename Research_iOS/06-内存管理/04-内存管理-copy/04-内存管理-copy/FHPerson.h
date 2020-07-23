//
//  FHPerson.h
//  37-内存管理-copy
//
//  Created by wangfh on 2018/9/25.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHPerson : NSObject <NSCopying>

@property (assign, nonatomic) int age;
@property (assign, nonatomic) double weight;

@end

NS_ASSUME_NONNULL_END
