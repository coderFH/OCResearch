//
//  main.m
//  08-initialize
//
//  Created by wangfh on 2018/7/17.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHStudent.h"
#import "FHCat.h"
#import "FHDog.h"

/*
 1.Category的实现原理
    Category编译之后的底层结构是struct category_t，里面存储着分类的对象方法、类方法、属性、协议信息在程序运行的时候，runtime会将Category的数据，合并到类信息中（类对象、元类对象中）
 
 2.Category和Class Extension的区别是什么？
    Class Extension在编译的时候，它的数据就已经包含在类信息中
    Category是在运行时，才会将数据合并到类信息中

 3.load、initialize方法的区别什么？
    1.调用方式
        1> load是根据函数地址直接调用
        2> initialize是通过objc_msgSend调用
 
    2.调用时刻
        1> load是runtime加载类、分类的时候调用（只会调用1次）
        2> initialize是类第一次接收到消息的时候调用，每一个类只会initialize一次（父类的initialize方法可能会被调用多次）
 
4.load、initialize的调用顺序？
    1.load
        1> 先调用类的load
            a) 先编译的类，优先调用load
            b) 调用子类的load之前，会先调用父类的load
 
        2> 再调用分类的load
            a) 先编译的分类，优先调用load
 
    2.initialize
        1> 先初始化父类
        2> 再初始化子类（可能最终调用的是父类的initialize方法）
 
5.Category中有load方法吗？load方法是什么时候调用的？load 方法能继承吗？
    有load方法
    load方法在runtime加载类、分类的时候调用
    load方法可以继承，但是一般情况下不会主动去调用load方法，都是让系统自动调用
 
 6.Category能否添加成员变量？如果可以，如何给Category添加成员变量？
    不能直接给Category添加成员变量，但是可以间接实现Category有成员变量的效果
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*
         1. +initialize方法会在类第一次接收到消息时调用
         2.调用顺序
            1.先调用父类的+initialize，再调用子类的+initialize
            2.(先初始化父类，再初始化子类，每个类只会初始化1次)

         +initialize和+load的很大区别是，+initialize是通过objc_msgSend进行调用的，所以有以下特点
         如果子类没有实现+initialize，会调用父类的+initialize（所以父类的+initialize可能会被调用多次）
         如果分类实现了+initialize，就覆盖类本身的+initialize调用
         */
        [FHCat alloc];
        [FHDog alloc];
        [FHStudent alloc];//如果子类没有实现+initialize，会调用父类的+initialize（所以父类的+initialize可能会被调用多次）
        
    }
    return 0;
}
