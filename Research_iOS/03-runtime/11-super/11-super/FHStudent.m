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
 
 其实super的意思只是告诉编译器从父类开始查找方法,本质上的调用者还是可以理解为(self),也就是FHStudent
 class方法和superclass方法其实都是 NSObject(重点:是NSObject方法实现的) 方法中实现的
 当[super class]这个方法执行时,会从FHPerson依次往上查找class方法或者superclass方法
 具体class方法的实现可以参考下边写的推测
 所以就不难理解为啥[super class]调用后打印的是FHStudent了,因为本质的调用者还是self
 
 super的底层其实是这种代码
 struce abc = {
    self,
    [FHPerson class], // 当前调用者的父类
 }
 objc_msgSendSuper(abc,sel_registerName("calss")); 第一个参数是结构体,结构体第一个参数是当前调用者,第二个参数是父类,也就是从哪里开始寻找要调用的方法
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
