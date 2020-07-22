//
//  main.m
//  11-block的类型
//
//  Created by wangfh on 2018/7/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

int height;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*
         block有3种类型，可以通过调用class方法或者isa指针查看具体类型，最终都是继承自NSBlock类型
         __NSGlobalBlock__ (_NSConcreteGlobalBlock) 全局 程序的数据区域 没有访问auto变量              复制效果:什么也不做
         __NSStackBlock__  (_NSConcreteStackBlock ) 栈               访问了auto变量                复制效果:从栈复制到堆
         __NSMallocBlock__ (_NSConcreteMallocBlock) 堆               __NSStackBlock__调用了copy   复制效果:引用计数增加
          // 堆：动态分配内存,需要程序员申请申请，也需要程序员自己管理内存
         */
        
        //结论一:如果block没有访问auto变量则其类型为:__NSGlobalBlock
        //对于这种类型的block我们不需要考虑作用域的问题,而且对他进行copy或者retain操作也是无效的.
        //没有访问任何变量
        void (^block1)(void) = ^{
            NSLog(@"Hello World");
        };
        //访问全局变量
        void (^block2) (void) = ^{
            NSLog(@"height is %d",height);
            
        };
        //访问static修饰的局部变量
        static int age = 10;
        void (^block3) (void) = ^{
            NSLog(@"age is %d",age);
            
        };
        NSLog(@"%@--%@---%@",[block1 class],[block2 class],[block3 class]);

        
        //结论二:如果block访问了auto修饰的变量则其类型为:__NSStackBlock
        //因为__NSStackBlock__的内存是分配在栈段的,所以在访问某些局部变量时,变量释放后,block拿到的数据就是垃圾数据了,我们只需要将block进行copy操作即可.
        //所以在开发中,我们经常会 对 block进行Copy操作 原因就是因为这个
        int age1 = 10;
        void (^block4)(void) = ^{
            NSLog(@"Hello - %d", age1);
        };//这个结果其实是__NSStackBlock__ 因为arc环境下,内部会有一个copy,所以打印的结果是__NSMallocBlock__
        NSLog(@"%@",[block4 class]);
        
        NSLog(@"%@", [^{
            NSLog(@"%d", age);//__NSGlobalBlock__ __NSMallocBlock__ __NSStackBlock__
        } class]);
    }
    return 0;
}

