//
//  main.m
//  22-runtime-class面试题
//
//  Created by wangfh on 2018/8/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //[NSObject class] 这样去取 拿到的还是类对象
        NSLog(@"%d", [[NSObject class] isKindOfClass:[NSObject class]]);
        NSLog(@"%d", [[NSObject class] isMemberOfClass:[NSObject class]]);
        NSLog(@"%d", [[FHPerson class] isKindOfClass:[FHPerson class]]);
        NSLog(@"%d", [[FHPerson class] isMemberOfClass:[FHPerson class]]);
        
        //所以对上边的进行简化 就是
        NSLog(@"%d", [NSObject isKindOfClass:[NSObject class]]);
        NSLog(@"%d", [NSObject isMemberOfClass:[NSObject class]]);
        NSLog(@"%d", [FHPerson isKindOfClass:[FHPerson class]]);
        NSLog(@"%d", [FHPerson isMemberOfClass:[FHPerson class]]);
        
        NSLog(@"=======================探索研究(对象方法)=============");
        id person = [[FHPerson alloc] init];
        //本质就是 你 传进去的person的类对象 是不是 传进去的类对象
        //所以很明显  就是 1,0
        NSLog(@"%d",[person isMemberOfClass:[FHPerson class]]); //1
        NSLog(@"%d",[person isMemberOfClass:[NSObject class]]); //0
        
        //本质就是 你 传进去的person的类对象 是不是 传进去的 类对象或者子类的对象
        //所以很明显  就是 1,1
        NSLog(@"%d",[person isKindOfClass:[FHPerson class]]); //1
        NSLog(@"%d",[person isKindOfClass:[NSObject class]]); //1
        
        NSLog(@"=======================探索研究(类方法)=============");
        //类方法 可以理解为  左边传进去对象的元类对象 是否是 右边的元类对象
        //也就是 FHPerson的元类对象 是否是 传进去的元类对象
        //很显然[FHPerson class] 是类对象 所是0
        NSLog(@"%d",[FHPerson isMemberOfClass:[FHPerson class]]); //0
        //这种情况下objc_getClass([FHPerson class] 获取元类
        //即 FHPerson的元类对象 是 传进去的元类对象 所以是1
        NSLog(@"%d",[FHPerson isMemberOfClass:object_getClass([FHPerson class])]);//1
                     
        NSLog(@"%d",[FHPerson isKindOfClass:[FHPerson class]]); //0 右边传的不是元类 所以很明显是0
        
        //回顾以前的内容,NSObject的元类再往上查,其实会查到自己的类对象,所以会是1
        NSLog(@"%d",[FHPerson isKindOfClass:[NSObject class]]); //1
    }
    return 0;
}
