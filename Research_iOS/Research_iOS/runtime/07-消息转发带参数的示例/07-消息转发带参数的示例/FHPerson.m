//
//  FHPerson.m
//  07-消息转发带参数的示例
//
//  Created by wangfh on 2020/7/21.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import "FHPerson.h"
#import <objc/runtime.h>
#import "FHCat.h"

@implementation FHPerson


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(setAge:)) {
//        return [NSMethodSignature signatureWithObjCTypes:"i20@0:8i16"];
        return [NSMethodSignature signatureWithObjCTypes:"i@:i"]; // 不要数字也可以
        // 如果你觉得每次都写v20@0:8i16这种东西很麻烦,可以新建一个类,定义一个参数和返回值都一样的方法,然后借助该类去生成方法签名,具体如下
//        return [[[FHCat alloc] init] methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    //1. 我这里可以什么都不实现
     
    //2. 也可以对外部传的10进行+10操作
    int age;
    [anInvocation getArgument:&age atIndex:2];
    NSLog(@"%d", age + 10);
    
    //3. 也可以取到返回值
    //    anInvocation.target = [[FHCat alloc] init];
    //    [anInvocation invoke];
    //这一句[anInvocation invokeWithTarget:[[FHCat alloc] init]] 下边这一句等于上边两句
    
    [anInvocation invokeWithTarget:[[FHCat alloc] init]]; //更改target的指向,本来是FHPerson
    int res;
    [anInvocation getReturnValue:&res];
    NSLog(@"%d",res);
}

@end
