//
//  main.m
//  01-OC对象
//
//  Created by wangfh on 2018/7/10.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

/*
一个NSObject对象占用多少内存？
系统分配了16个字节给NSObject对象（通过malloc_size函数获得）
但NSObject对象内部只使用了8个字节的空间（64bit环境下，可以通过class_getInstanceSize函数获得）

对象的isa指针指向哪里？
instance对象的isa指向class对象
class对象的isa指向meta-class对象
meta-class对象的isa指向基类的meta-class对象

OC的类信息存放在哪里？
对象方法、属性、成员变量、协议信息，存放在class对象中
类方法，存放在meta-class对象中
成员变量的具体值，存放在instance对象*/

#pragma mark ----- 单纯的NSObject -----
/*
 在OC中的定义
 @interface NSObject <NSObject> {
    Class isa  OBJC_ISA_AVAILABILITY;
 }
 
 xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m -o main.cpp
 
 转成C++代码之后
 struct NSObject_IMPL {
     Class isa;  // 8个字节
 };
*/

#pragma mark ----- 测试Student -----
@interface Student : NSObject {
    @public
    int _no; //4
    //占用的内存控制是isa8+4=12个字节 因为内存对齐的原因,所以会是16个字节
    //内存对齐:结构体的大小必须是最大成员大小的倍数,在这里也就是8的倍数
}
@end

@implementation Student
@end

#pragma mark ----- 测试Person -----
@interface Person : NSObject {
@public
    int _age;
    int _height;
    double _source;
}
@property (nonatomic, assign) int height;
@end

//底层isa的实现
struct NSObject_IMPL {
    Class isa;
};

//Person其实转化成c++代码是这种形式的
struct Person_IMPL {
    struct NSObject_IMPL NSObject_IVARS; //8
    int _age; //4
    int _height; //4
    double _source;//4
    //12 + 8 = 20 因为内存对齐 会是8的倍数  也就是需要24个字节
    //由此可以person对象创建出来之后,其实分配24个字节就够了,可以用sizeof去验证,也可用用class_getInstanceSize去验证
    //但是系统真正分配可能不止24个字节,因为系统会考虑其性能,所以分配出来的会是32个字节
};

@implementation Person
@end

/*
创建一个实例对象，至少需要多少内存？
#import <objc/runtime.h>
class_getInstanceSize([NSObject class]);

创建一个实例对象，实际上分配了多少内存？
#import <malloc/malloc.h>
malloc_size((__bridge const void *)obj);
 */
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"----------------单纯的NSObject------------");
        NSObject *obj = [[NSObject alloc] init];
        
        //获得NSObject实例对象的成员变量所占用的大小 >> 8
        NSLog(@"%zd",class_getInstanceSize([NSObject class]));
        
        //获取obj指针所指向内存的大小 >> 16
        NSLog(@"%zd",malloc_size((__bridge const void *)obj));
        
        // 模拟器(i386)、32bit(armv7)、64bit（arm64）
        NSLog(@"----------------测试student------------");
        Student *stu = [[Student alloc] init];
        NSLog(@"%zd", class_getInstanceSize([Student class])); //16
        NSLog(@"%zd", malloc_size((__bridge const void *)stu)); //16
        
        NSLog(@"----------------测试Person------------");
        Person *per = [[Person alloc] init];
        NSLog(@"%zd", sizeof(struct Person_IMPL)); //24
        NSLog(@"%zd", class_getInstanceSize([Person class]));//24
        NSLog(@"%zd", malloc_size((__bridge const void *)per));//32
    }
    return 0;
}
