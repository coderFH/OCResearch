//
//  main.m
//  15-block-__block
//
//  Created by wangfh on 2018/7/25.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 __block可以用于解决block内部无法修改auto变量值的问题
 __block不能修饰全局变量、静态变量（static）
 编译器会将__block变量包装成一个对象
 */

typedef void (^FHBlock)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        __block __weak int age = 10;
        
        FHBlock block1 = ^{
            __strong int myage = age;
            age = 20;
            NSLog(@"age is %d", age);
        };
        
        FHBlock block2 = ^{
            age = 30;
            NSLog(@"age is %d", age);
        };
        
        block1();
        block2();
    }
    return 0;
}
