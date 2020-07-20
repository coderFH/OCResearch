//
//  main.m
//  01-搞懂isa必备知识
//
//  Created by wangfh on 2020/7/20.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*
         需求: 给定一个FHPerson对象,有三个属性,tall.rich,handsome,如何处理使FHPerson占据最少的空间
        */
        
        /*
        FHPerson *p = [[FHPerson alloc] init];
        p.tall = YES;
        p.rich = YES;
        p.handsome = YES;
        NSLog(@"%d %d %d",p.tall,p.rich,p.handsome);
        NSLog(@"%zd",class_getInstanceSize([FHPerson class]));
         */
        
        FHPerson *p = [[FHPerson alloc] init];
        p.tall = NO;
        p.rich = YES;
        p.handsome = YES;
        NSLog(@"tall:%d rich:%d handsome:%d",p.isTall,p.isRich,p.isHandsome);
        NSLog(@"%zd",class_getInstanceSize([FHPerson class]));
    }
    return 0;
}
