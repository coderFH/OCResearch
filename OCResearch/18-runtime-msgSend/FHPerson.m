//
//  FHPerson.m
//  18-runtime-msgSend
//
//  Created by wangfh on 2018/8/22.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHPerson.h"
#import <objc/runtime.h>
#import "FHCat.h"

@implementation FHPerson

#pragma mark --正常的消息发送
- (void)personTest {
    NSLog(@"%s", __func__);
}

#pragma mark --动态方法解析
//======================动态添加类方法======================
//这是个c语言的函数,也是可以动态调用的
void c_other(id self, SEL _cmd)
{
    NSLog(@"c_other - %@ - %@", self, NSStringFromSelector(_cmd));
}

//动态的去添加方法
+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(dongTaiFangFa)) {
        // 第一个参数是object_getClass(self)
        class_addMethod(object_getClass(self), sel, (IMP)c_other, "v16@0:8");
        return YES;
    }
    return [super resolveClassMethod:sel];
}



//======================动态添加实例方法======================
//Method类型的本质就是一个这种类型的结构体
struct method_t {
    SEL sel;
    char *types;
    IMP imp;
};

- (void)other {
    NSLog(@"%s",__func__);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(test)) {
//        //获取其他方法(其实这句返回的是Method类型的,但是Method类型本质是struct method_t的结构体)
//        struct method_t *otherMethod = (struct method_t *)class_getInstanceMethod(self, @selector(other));
//        //动态添加test的实现
//        class_addMethod(self, sel, otherMethod->imp, otherMethod->types);
        
        //如果不使用上边那两句强转Method类型的方式,也可以使用下边的方式
//        Method otherMethod = class_getInstanceMethod(self, @selector(other));
//        class_addMethod(self, sel, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod));
        
        //也可以动态的添加C语言的函数
        class_addMethod(self, sel, (IMP)c_other, "v16@0:8");

        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

#pragma mark --消息转发
//============对象方法============
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(xiaoXiZhuanFa)) {
//        //返回一个可以处理这个方法的对象
//        return [[FHCat alloc] init];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

//如果不实现上边这个方法,会调用下面这两个方法
/*
为什么只实现上边那个方法就可以实现消息转发,还要下边这两个这么麻烦的方法呢?
因为在forwardInvocation这个方法里边,可以很自由,想干嘛就干嘛,可以更改调用的方法(anInvocation.selector)
还可以修改参数([anInvocation getArgument:NULL atIndex:0])等等
 */
//返回方法签名:返回值类型,参数类型
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(xiaoXiZhuanFa)) {
//        return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
//        或者
        return [[[FHCat alloc] init] methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}

//NSInvocation封装了一个方法调用:包括:方法调用者,方法,方法参数
- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    anInvocation.target:方法调用者
//    anInvocation.selector:方法名
//    参数顺序: receiver,selector,other arguments
//    [anInvocation getArgument:NULL atIndex:0]
    
//    anInvocation.target = [[FHCat alloc] init];
//    [anInvocation invoke];
    
//    [anInvocation invokeWithTarget:[[FHCat alloc] init]];
    
    //你在外部调用的方法,转发的这里,你可以想干啥就干啥
    NSLog(@"-------------");
}

//============类方法============
+ (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(leiTest)) {
        return [FHCat class];
    }
    return [super forwardingTargetForSelector:aSelector];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(leiTest)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"===========");
}

@end
