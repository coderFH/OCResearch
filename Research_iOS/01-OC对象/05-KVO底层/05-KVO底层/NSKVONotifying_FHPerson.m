//
//  NSKVONotifying_FHPerson.m
//  04-KVO底层
//
//  Created by wangfh on 2018/7/12.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "NSKVONotifying_FHPerson.h"

@implementation NSKVONotifying_FHPerson

- (void)setAge:(int)age
{
//    _NSSetIntValueAndNotify();
}

// _NSSetIntValueAndNotify内部的伪实现
//- (void)_NSSetIntValueAndNotify() {
//    [self willChangeValueForKey:@"age"];
//    [super setAge:age];
//    [self didChangeValueForKey:@"age"];
//}

// 除了重写了set方法,还重写了以下三个方法
// 屏蔽内部实现，隐藏了NSKVONotifying_FHPerson类的存在
- (Class)class
{
    return [FHPerson class];
}

- (void)dealloc
{
    // 收尾工作
}

- (BOOL)_isKVOA
{
    return YES;
}

@end
