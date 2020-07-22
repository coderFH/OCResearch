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
    if (sel == @selector(test)) { // 如果传进来的是test方法,才走我的动态方法解析
        
        // 动态的添加方法的方式1:
        //获取其他方法(其实这句返回的是Method类型的,但是Method类型本质是struct method_t的结构体)
//        struct method_t *otherMethod = (struct method_t *)class_getInstanceMethod(self, @selector(other));
//        //动态为test添加方法,
//        // 第一个参数:self,是类对象,因为添加的是实例方法,所以方法应该加入到类对象中
//        // 第二个参数: 添加方法的方法名
//        class_addMethod(self, sel, otherMethod->imp, otherMethod->types); // 动态的添加一个other方法,方法的名字是test,是加入到类对象的class_rw_t中
        
        // 动态的添加方法的方式2:
        //如果不使用上边那两句强转Method类型的方式,也可以使用下边的方式
//        Method otherMethod = class_getInstanceMethod(self, @selector(other));
//        class_addMethod(self, sel, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod));//动态的添加一个other方法,方法的名字是test,加入到类对象的class_rw_t中
        
        // 动态的添加方法的方式3:
        // 也可以动态的添加C语言的函数
        class_addMethod(self, sel, (IMP)c_other, "v16@0:8");//动态的添加一个c_other方法,方法的名字是test,加入到类对象的class_rw_t中

        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

#pragma mark ------- 消息转发 -----
//============消息转发:对象方法============
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(xiaoXiZhuanFa)) {
//        //返回一个可以处理这个方法的对象
//        return [[FHCat alloc] init]; // FHCat一定是能处理xiaoXiZhuanFa这个方法的对象,如果FHCat没有实现xiaoXiZhuanFa,照样崩溃
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}


// 如果forwardingTargetForSelector没有实现,就会调用methodSignatureForSelector
/*
为什么只实现上边forwardingTargetForSelector方法就可以实现消息转发,还要下边methodSignatureForSelector这个方法呢? 这不是很麻烦么?
 1.runtime在消息转发时,会先判断有没有实现forwardingTargetForSelector这个方法,如果没有实现或者返回是nil,会调用methodSignatureForSelector方法,这是runtime的一个流程问题
 2.在methodSignatureForSelector方法中返回方法的签名,并且调用forwardInvocation方法,参数是anInvocation,
 而anInvocation会对调用者(当前对象),方法,typeEncoding等进行包装,然后在forwardInvocation这个方法里,你可以拿到包装的对象做任何操作,
 比如可以更改调用的方法(anInvocation.selector),或者更改调用者(anInvocation.target),还可以修改参数([anInvocation getArgument:NULL atIndex:0])等,可以说非常自由
 甚至在forwardInvocation可以不做任何操作
 */

//返回方法签名:返回值类型,参数类型
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(xiaoXiZhuanFa)) {
//        return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
//        或者
        // 这里只是借助FHCat类中的xiaoXiZhuanFa方法,去生成一个方法签名,并没有修改调用者是FHCat,需要注意
        return [[[FHCat alloc] init] methodSignatureForSelector:aSelector]; // 如果返回的方法签名是有值的并且合理,会调用forwardInvocation
    }
    return [super methodSignatureForSelector:aSelector];
}

//NSInvocation封装了一个方法调用,包括:方法调用者,方法,方法参数
- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    anInvocation.target:方法调用者
//    anInvocation.selector:方法名
//    参数顺序: receiver,selector,other arguments
//    [anInvocation getArgument:NULL atIndex:0]

//    anInvocation.target = [[FHCat alloc] init]; // 我在该方法中可以修改方法的调用者,是不是很自由
//    [anInvocation invoke]; //调用方法

//    // 这一句等于上边两句
//    [anInvocation invokeWithTarget:[[FHCat alloc] init]];

    //你在外部调用的方法,转发的这里,你可以想干啥就干啥
    NSLog(@"-------------");
}

//======================= 消息转发:类方法===================================
+ (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(leiTest)) {
//        return [[FHCat alloc] init]; // 这里可以返回实例对象,原因就是你要弄清楚其实本质其实还是objc_msgsend([[FHCat alloc] init],@select(leiTest)),如果你有- (void)leiTest,当然是可以调用的
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
