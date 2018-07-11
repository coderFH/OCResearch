//
//  main.m
//  02-OC对象-class对象
//
//  Created by wangfh on 2018/7/11.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
/*
Object-C中的对象,主要可以分为3种
instance对象(实例对象)
    instance对象在内存中存储的信息包括:
        1.isa指针
        2.其他 成员变量
class对象(类对象)
    class对象在内存中存储的信息主要包括:
        1.isa指针
        2.superclass指针
        3.类的属性信息（@property）、类的对象方法信息（instance method）
        4.类的协议信息（protocol）、类的成员变量信息（ivar）
meta-class对象(元类对象)
    meta-class对象在内存中存储的信息主要包括:
        1.isa指针
        2.superclass指针
        3.类的类方法信息（class method）
 
 注意:meta-class对象和class对象的内存结构是一样的,比如类对象不存储类方法的信息,但内存中还是会有该片段,只不过该位置会存null而已
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"-----------------实例对象------------------");
        //instance对象就是通过类alloc出来的对象，每次调用alloc都会产生新的instance对象
        NSObject *obj1 = [[NSObject alloc] init];
        NSObject *obj2 = [[NSObject alloc] init];
        NSLog(@"%p %p",obj1,obj2);//它们是不同的两个对象，分别占据着两块不同的内存
        
        NSLog(@"-----------------类对象------------------");
        Class objClass1 = [obj1 class];
        Class objClass2 = [obj2 class];
        Class objClass3 = [NSObject class];
        Class objClass4 = object_getClass(obj1);
        Class objClass5 = object_getClass(obj2);
        //objectClass1 ~ objectClass5都是NSObject的class对象（类对象）
        //它们是同一个对象。每个类在内存中有且只有一个class对象
        NSLog(@"%p %p %p %p %p",objClass1,objClass2,objClass3,objClass4,objClass5);
        
        NSLog(@"-----------------元类对象------------------");
        Class objectMetaClass = object_getClass([NSObject class]);
        NSLog(@"%p",objectMetaClass);
        
        NSLog(@"-----------------注意------------------");
        //以下代码获取的objectClass是class对象，并不是meta-class对象
        Class objectClass = [[NSObject class] class];
        NSLog(@"%p",objectClass);
        
        //查看Class是否为meta-class
        BOOL result = class_isMetaClass(object_getClass([NSObject class]));
        BOOL result1 = class_isMetaClass([NSObject class]);
        NSLog(@"%d %d",result,result1);
    }
    return 0;
}

/*
 1.
 Class objc_getClass(const char *aClassName)
    1> 传入字符串类名
    2> 返回对应的类对象
 
 2.
 Class object_getClass(id obj)
    1> 传入的obj可能是instance对象、class对象、meta-class对象
    2> 返回值
        a) 如果是instance对象，返回class对象
        b) 如果是class对象，返回meta-class对象
        c) 如果是meta-class对象，返回NSObject（基类）的meta-class对象
 
 3.
 - (Class)class
 + (Class)class
    1> 返回的就是类对象
 
 - (Class) {
    return self->isa;
 }
 
 + (Class) {
    return self;
 }
 */
