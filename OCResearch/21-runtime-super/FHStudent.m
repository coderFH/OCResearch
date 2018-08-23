//
//  FHStudent.m
//  21-runtime-super
//
//  Created by wangfh on 2018/8/23.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHStudent.h"

@implementation FHStudent

/*
 [super message]的底层实现
 1.消息接收者仍然是子类对象
 2.从父类开始查找方法的实现
 */

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"[self class] = %@", [self class]); // FHStudent
        NSLog(@"[self superclass] = %@", [self superclass]); // FHPerson
        
        NSLog(@"--------------------------------");
        
        // objc_msgSendSuper({self, [FHPerson class]}, @selector(class));
        NSLog(@"[super class] = %@", [super class]); // FHStudent
        NSLog(@"[super superclass] = %@", [super superclass]); // FHPerson
    }
    return self;
}

/*
 NSObject底层实现class方法的推测
@implementation NSObject

- (Class)class
{
    return object_getClass(self);
}

- (Class)superclass
{
    return class_getSuperclass(object_getClass(self));
}
*/


@end
