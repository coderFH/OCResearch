//
//  FHProxy1.h
//  34-内存管理-定时器
//
//  Created by wangfh on 2018/9/7.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHProxy1 : NSProxy

+ (instancetype)proxyWithTarget:(id)target;
@property (weak, nonatomic) id target;

@end
