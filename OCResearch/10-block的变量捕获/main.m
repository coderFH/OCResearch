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
        //==================== block的本质======================
        //以下代码也可以看出block是一个对象
        void(^easyBlock)(void) = ^{
            NSLog(@"Hello World");
        };
        NSLog(@"%@",[easyBlock class]);//__NSGlobalBlock__
        NSLog(@"%@",[[easyBlock class] superclass]);//__NSGlobalBlock
        NSLog(@"%@",[[[easyBlock class] superclass] superclass]);//NSBlock
        NSLog(@"%@",[[[[easyBlock class] superclass] superclass] superclass]);//NSObject
//        通过下面的命令将我们的.m文件转化成.cpp文件
//        xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m
        /*
        block转化的底层样式
        struct __block_impl {
            void *isa;//通过该指针我们可以看出block的本质就是一个OC对象
            int Flags;
            int Reserved;
            void *FunPtr;
        };
        struct __main_block_impl_0 { //block的内部结构其实就是该结构体
            struct __block_impl impl;
            struct __main_block_desc_0 *Desc;
            //以下还有一个构造方法,会对__block_impl进行一个赋值操作
        };
        struct __main_block_desc_0 {
            size_t reserved;
            size_t Block_size;//计算block所占用的内存大小
        };
        */

        NSLog(@"==================== block的变量捕获======================");
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

        /*
         struct __main_block_impl_0 { //block的内部结构其实就是该结构体
            struct __block_impl impl;
            struct __main_block_desc_0 *Desc;
            int age;//可以看到会复制一个age到自己block的内部,值传递
         };
         */
        
        //==================== static:会捕获到block内部  访问方式是指针传递======================
        static int height = 10;
        void (^block1)(void) = ^{
            NSLog(@"height is %d",height);
            height = 30;
        };
        height = 20;
        block1();
        NSLog(@"height is %d",height);
        /*
         用Static修饰的height和age是不一样的,age是一个值传递,而height是一个引用传递,所以在block外部即使height的数据变更我们也可以获取到最新的数据.
         struct __main_block_impl_0 { //block的内部结构其实就是该结构体
             struct __block_impl impl;
             struct __main_block_desc_0 *Desc;
             int *height;
         };
         */
        
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
