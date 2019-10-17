//
//  main.m
//  13-block-对象类型的auto变量
//
//  Created by wangfh on 2018/7/25.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"

/*
 当block内部访问了对象类型的auto变量时
    如果block是在栈上，将不会对auto变量产生强引用(arc和mrc下都一样)
 
 如果block被拷贝到堆上
    会调用block内部的copy函数
    copy函数内部会调用_Block_object_assign函数
    _Block_object_assign函数会根据auto变量的修饰符（__strong、__weak、__unsafe_unretained）做出相应的操作，形成强引用（retain）或者弱引用
 
 如果block从堆上移除
    会调用block内部的dispose函数
    dispose函数内部会调用_Block_object_dispose函数
    _Block_object_dispose函数会自动释放引用的auto变量（release）
 */

typedef void (^FHBlock)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHBlock block1;
        {
            FHPerson *p = [[FHPerson alloc] init];
            p.age = 10;
            __weak FHPerson *weakP = p;
            //此时的block在arc环境下,已经是在堆区了
            block1 = ^{ //block引用了对象类型auto变量,会持有这个person对象,所以在42行出了大括号的时候,person对象并不会释放,只有当block1这个强指针释放时,block才会释放,相应的person对象才会释放,所以会先打印'------',然后再打印'FHPerson - dealloc'
                //假如换成weakP,block其实是弱引用这person对象,所以过了42行后,person对象会马上释放
                NSLog(@"---------%d",weakP.age);
            };
        }
        NSLog(@"------");
    }
    return 0;
}
