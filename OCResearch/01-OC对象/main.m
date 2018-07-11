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

// NSObject Implementation
//struct NSObject_IMPL {
//    Class isa; // 8个字节
//};

//----------------测试Student------------
@interface Student : NSObject {
    @public
    int _no; //4
    //占用的内存控制是isa8+4=12个字节 因为内存对齐的原因,所以会是16个字节
    //内存对齐:结构体的大小必须是最大成员大小的倍数,在这里也就是8的倍数
}
@end

@implementation Student
@end

//----------------测试Person---------------------------------------------------------
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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"----------------单纯的NSObject------------");
        NSObject *obj = [[NSObject alloc] init];
        //获得NSObject实例对象的成员变量所占用的大小 >>8
        NSLog(@"%zd",class_getInstanceSize([NSObject class]));
        
        //获取obj指针所指向内存的大小 >> 16
        NSLog(@"%zd",malloc_size((__bridge const void *)obj));
        
        // 模拟器(i386)、32bit(armv7)、64bit（arm64）
        NSLog(@"----------------测试student------------");
        Student *stu = [[Student alloc] init];
        NSLog(@"%zd", class_getInstanceSize([Student class]));
        NSLog(@"%zd", malloc_size((__bridge const void *)stu));
        
        NSLog(@"----------------测试Person------------");
        Person *per = [[Person alloc] init];
        NSLog(@"%zd", sizeof(struct Person_IMPL));
        NSLog(@"%zd", class_getInstanceSize([Person class]));
        NSLog(@"%zd", malloc_size((__bridge const void *)per));
        
    }
    return 0;
}
