//
//  main.m
//  12-block的copy
//
//  Created by wangfh on 2018/7/25.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 在ARC环境下，编译器会根据情况自动将栈上的block复制到堆上，比如以下情况
    1.block作为函数返回值时
    2.将block赋值给__strong指针时
    3.block作为Cocoa API中方法名含有usingBlock的方法参数时
    4.block作为GCD API的方法参数时
 
 MRC下block属性的建议写法
    @property (copy, nonatomic) void (^block)(void);
 
 ARC下block属性的建议写法
    @property (strong, nonatomic) void (^block)(void);
    @property (copy, nonatomic) void (^block)(void);
 */
typedef void (^FHBlock)(void);

FHBlock myblock() {
    return ^{
        NSLog(@"--------");
    };
}

FHBlock myblock1() {
    int age = 10;
    return ^{
        NSLog(@"--------%d",age);
    };
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHBlock block = myblock();
        block();
        NSLog(@"=====%@",[block class]); //这个返回block的函数没有引用auto变量,所以就是一个全局的block__NSGlobalBlock__
        
        //1.block作为函数返回值时
        FHBlock block1 = myblock1();
        block1();
        //这个返回block的函数引用auto变量,默认是在stack,但是是arc环境,所以会自动进行一个copy,复制到堆区
        NSLog(@"####%@",[block1 class]); // __NSMallocBlock__
        
        //2.将block赋值给__strong指针时
        /*可以看到,此block虽然引用了auto的变量,但他本身并没有__block的一个指针去强引用他,所以也是在栈区
         如果想让强指针引用,可以这么改
            int age = 10;
            FHBlock block = ^{
                NSLog(@"---------%d", age);
            };
            NSLog(@"%@", [block class]);//有强指针指向,自动调用了copy到堆区
        */
        int age = 10;
        NSLog(@"****%@", [^{
            NSLog(@"---------%d", age);
        } class]);//__NSStackBlock__  因为没有强指针指向  上边注释的有强指针指向  就是在堆区
        
        // 3.block作为Cocoa API中方法名含有usingBlock的方法参数时,也会进行一次copy操作
        NSArray *array = [NSArray array];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
        }];
        
        //4.block作为GCD API的方法参数时
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
        });
        
        
        
    }
    return 0;
}
