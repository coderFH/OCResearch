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

/*
 __block的内存管理:
    1.当block在栈上时，仅仅是使用了__block变量，并没有对__block变量产生强引用
    2.当block被copy到堆时,
      会调用block内部的copy函数,
      copy函数内部会调用_Block_object_assign函数
      _Block_object_assign函数会对__block变量产生强引用（仅当ARC时才有效,MRC时候并不会对__block变量产生强引用）
    3.当block从堆中移除时
      会调用block内部的dispose函数
      dispose函数内部会调用_Block_object_dispose函数
      _Block_object_dispose函数会自动释放引用的__block变量
 */

typedef void (^FHBlock)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        __block __weak int age = 10;
//
//        FHBlock block1 = ^{
//            __strong int myage = age;
//            age = 20;
//            NSLog(@"age1 is %d", age);
//        };
//
//        FHBlock block2 = ^{
//            age = 30;
//            NSLog(@"age2 is %d", age);
//        };
//
//        block1();
//        block2();
        
        //一个面试题,a的地址会不会变
        __block int a = 1;
        NSLog(@"%d %p",a,&a);

        void (^block)(void) = ^{
            a = 3;
            NSLog(@"%d %p",a,&a);
        };

        a = 2;
        NSLog(@"%d %p",a,&a);
        block();
        NSLog(@"%d %p",a,&a);
        
        
        
        // 下面一个问题,在block中,对可变数组追加元素,需要用__block修饰么?
        // 不需要? 因为addObject本质是向数组中添加元素,并没有修改array,所以不需要使用__block修饰
        NSMutableArray *array = [[NSMutableArray alloc] init];
        FHBlock block1 = ^{
            [array addObject:@"1"];
            [array addObject:@"2"];
            NSLog(@"%lu",(unsigned long)array.count);
        };
        
        NSLog(@"%lu",(unsigned long)array.count);
        block1();
        NSLog(@"%lu",(unsigned long)array.count);
        
    }
    return 0;
}

/*
 __block int age = 10;
 ^{
    NSLog(@"%d",age);
 }();
 //底层会转化为
 struct __main_block_impl_0 {
     struct __block_impl impl;
     struct __main_block_desc_0* Desc;
     __Block_byref_age_0 *age;
 }
 
 struct __Block_byref_age_0 {
     void *__isa;
     __Block_byref_age_0 *__forwarding;
     int __flages;
     int __size;
     int age;
 }
 编译器会将__block变量包装成一个对象,然后将age的地址值传递给该对象,通过修改该对象内部的age来达到目的
 */
