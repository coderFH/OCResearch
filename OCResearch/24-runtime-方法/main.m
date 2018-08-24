//
//  main.m
//  24-runtime-方法
//
//  Created by wangfh on 2018/8/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "FHPerson.h"

void myrun() {
    NSLog(@"----myrun");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //================================替换方法================================
        FHPerson *person = [[FHPerson alloc] init];
        class_replaceMethod([FHPerson class], @selector(run),(IMP)myrun,"v");        
        [person run];
        
        class_replaceMethod([FHPerson class], @selector(run), imp_implementationWithBlock(^{
            NSLog(@"123123");
        }), "v");
        [person run];
        
        //================================交换方法================================
        FHPerson *p1 = [[FHPerson alloc] init];
        
        Method runMethod = class_getInstanceMethod([FHPerson class], @selector(run));
        Method testMethod = class_getInstanceMethod([FHPerson class], @selector(test));
        method_exchangeImplementations(runMethod, testMethod);

        [p1 run];
    }
    return 0;
}
