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
