//
//  main.m
//  17-runtime-isa详解
//
//  Created by Ne on 2018/8/8.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 1.要想学习Runtime，首先要了解它底层的一些常用数据结构，比如isa指针
    1.在arm64架构之前，isa就是一个普通的指针，存储着Class、Meta-Class对象的内存地址
    2.从arm64架构开始，对isa进行了优化，变成了一个共用体（union）结构，还使用位域来存储更多的信息
 
 2.isa详解-位域
 nonpointer
    0，代表普通的指针，存储着Class、Meta-Class对象的内存地址
    1，代表优化过，使用位域存储更多的信息
 
 has_assoc
    是否有设置过关联对象，如果没有，释放时会更快
 
 has_cxx_dtor
    是否有C++的析构函数（.cxx_destruct），如果没有，释放时会更快
 
 shiftcls
    存储着Class、Meta-Class对象的内存地址信息
 
 magic
    用于在调试时分辨对象是否未完成初始化
 
 weakly_referenced
    是否有被弱引用指向过，如果没有，释放时会更快
 
 deallocating
    对象是否正在释放
 
 extra_rc
    里面存储的值是引用计数器减1
 
 has_sidetable_rc
    引用计数器是否过大无法存储在isa中
    如果为1，那么引用计数会存储在一个叫SideTable的类的属性中
 */

typedef enum {
    //    FHOptionsNone = 0,    // 0b0000
    FHOptionsOne = 1<<0,   // 0b0001
    FHOptionsTwo = 1<<1,   // 0b0010
    FHOptionsThree = 1<<2, // 0b0100
    FHOptionsFour = 1<<3   // 0b1000
} FHOptions;

void setOptions(FHOptions options) {
    if (options & FHOptionsOne) {
        NSLog(@"包含了FHOptionsOne");
    }
    
    if (options & FHOptionsTwo) {
        NSLog(@"包含了FHOptionsTwo");
    }
    
    if (options & FHOptionsThree) {
        NSLog(@"包含了FHOptionsThree");
    }
    
    if (options & FHOptionsFour) {
        NSLog(@"包含了FHOptionsFour");
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //位运算
        setOptions(FHOptionsOne + FHOptionsTwo + FHOptionsFour);
    }
    return 0;
}
