//
//  NSObject+Test.m
//  03-OC对象-探究方法的调用
//
//  Created by wangfh on 2018/7/12.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "NSObject+Test.h"

@implementation NSObject (Test)

//+ (void)test
//{
//    NSLog(@"+[NSObject test] - %p", self);
//}

- (void)test
{
    NSLog(@"-[NSObject test] - %p", self);
}

@end
