//
//  Manage.m
//  44-单例模式
//
//  Created by wangfh on 2019/10/15.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "Manage.h"

@implementation Manage

+ (id)shareInstance {
    // 静态局部变量
    static Manage *instance = nil;
    
    //通过dispatch_once方式 确保instance在多线程环境下只能创建一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 创建实例  不使用self的原因是会引起循环引用
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

// 重写方法(必不可少)
+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return self;
}

@end
