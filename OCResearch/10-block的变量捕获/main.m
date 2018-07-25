//
//  main.m
//  10-block
//
//  Created by wangfh on 2018/7/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

/*
 block本质上也是一个OC对象，它内部也有个isa指针
 block是封装了函数调用以及函数调用环境的OC对象
 
 */
#import <Foundation/Foundation.h>

int weight_ = 10;
int age_ = 10;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //为了保证block内部能够正常访问外部的变量，block有个变量捕获机制
        
        /*
         局部变量:
         auto:  会捕获到block内部  访问方式是值传递
         static:会捕获到block内部  访问方式是指针传递
         全局变量:
         不会捕获到block内部 访问方式是直接访问
         */
        //==================== auto:  会捕获到block内部  访问方式是值传递======================
        int age = 10;
        void (^block)(void) = ^{
            NSLog(@"age is %d",age);
        };
        age = 20;
        block();
        
        NSString *name = @"wfh";
        void (^block11)(void) = ^{
            NSLog(@"name is %@",name);
        };
        name = @"fff";
        block11();
        
        //==================== static:会捕获到block内部  访问方式是指针传递======================
        static int height = 10;
        void (^block1)(void) = ^{
            NSLog(@"height is %d",height);
            height = 30;
        };
        height = 20;
        block1();
        NSLog(@"height is %d",height);
        
        //====================全局变量:不会捕获到block内部 访问方式是直接访问======================
        void (^block2)(void) = ^{
            NSLog(@"weight_ is %d,age_ is %d",weight_,age_);
            weight_ = 30;
            age_ = 30;
        };
        weight_ = 20;
        age_ = 20;
        block2();
        NSLog(@"weight_ is %d,age_ is %d",weight_,age_);
    }
    return 0;
}
