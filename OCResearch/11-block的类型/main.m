//
//  main.m
//  11-block的类型
//
//  Created by wangfh on 2018/7/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*
         block有3种类型，可以通过调用class方法或者isa指针查看具体类型，最终都是继承自NSBlock类型
         __NSGlobalBlock__ （ _NSConcreteGlobalBlock ） 没有访问auto变量 程序的数据区域 复制效果:什么也不做
         __NSStackBlock__ （ _NSConcreteStackBlock ） 访问了auto变量 栈 复制效果:从栈复制到堆
         __NSMallocBlock__ （ _NSConcreteMallocBlock ）__NSStackBlock__调用了copy 堆 复制效果:引用计数增加
         */
        
        // 堆：动态分配内存,需要程序员申请申请，也需要程序员自己管理内存
        void (^block1)(void) = ^{
            NSLog(@"Hello");
        };
        
        int age = 10;
        void (^block2)(void) = ^{
            NSLog(@"Hello - %d", age);
        };//这个结果其实是__NSStackBlock__ 因为arc环境下,内部会有一个copy,所以打印的结果是__NSMallocBlock__
        
        NSLog(@"%@ %@ %@", [block1 class], [block2 class], [^{
            NSLog(@"%d", age);//__NSGlobalBlock__ __NSMallocBlock__ __NSStackBlock__
        } class]);
    }
    return 0;
}
