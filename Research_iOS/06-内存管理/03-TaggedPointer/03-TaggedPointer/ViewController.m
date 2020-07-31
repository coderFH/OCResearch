//
//  ViewController.m
//  36-TaggedPointer
//
//  Created by wangfh on 2018/9/19.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, copy) NSString *name;

@end

//set方法本质的实现
//- (void)setName:(NSString *)name
//{
//    if (_name != name) {
//        [_name release];
//        _name = [name retain];
//    }
//}

int a = 10;
int b;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // =========================================== iOS程序内存布局 ================================================================
    /*
     iOS程序内存布局
     低
     |     保留
     |     代码段: 编译之后的代码
     |     数据段:
     |       字符串常量: 比如NSString *str = @"123"
     |       已初始化数据: 已初始化的全局变量,静态变量等
     |       未初始化数据: 未初始化的全局变量,静态变量
     |     堆: 通过alloc,malloc,calloc等动态分配的空间,分配的内存空间越来越大
     高    栈:函数调用开销,局部变量,分配的内存空间越来越小
     */
    static int c= 20;
    static int d;
    int e;
    int f = 20;
    int j = 30;
    NSString *g = @"123";
    NSObject *h = [[NSObject alloc] init];
    NSObject *i = [[NSObject alloc] init];
    NSLog(@"\n&a=%p\n \n&b=%p\n \n&c=%p\n \n&d=%p\n \n&e=%p\n \n&f=%p\n \n&g=%p\n \n&h=%p\n \n&i=%p\n \n&j=%p\n",&a,&b,&c,&d,&e,&f,g,h,i,&j);
    /*
     根据打印地址我们可以知道
     数据段
         字符常量区的 &g=0x1082ab020
         已初始化的全局变量,静态变量等  &a=0x1082ad550
                                    &c=0x1082ad554
        未初始化的全局变量,静态变量 &b=0x1082ad6dc
                                &d=0x1082ad6d8
     堆
        &h=0x600001dd8470
        &i=0x600001dd8480
     栈 (从高地址到低地址分配,所以e的地址值大)
        &e=0x7ffee6a3413c
        &f=0x7ffee6a34138
        &j=0x7ffee6a34134
     */
    
     // ============================================ taggerPointer =====================================================
    NSString *number1 = @"1";
    NSString *number2 = @"2";
    NSString *number3 = [NSString stringWithFormat:@"3"];
    NSLog(@"%p %p %p %@",number1,number2,number3,[number3 class]);
    
    //这段代码的运行结果是什么???
    //会崩溃,当多个线程去操作这个name属性的时候,因为调用了set方法,底层会对_name做一个release操作.而多个线程时,当_name已经释放了,另外一个线程再次释放就会造成坏内存访问.
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    for (int i = 0; i < 1000; i++) {
//        dispatch_async(queue, ^{
//            // 加锁
//            self.name = [NSString stringWithFormat:@"abcdefghijk"];
//
//        });
//    }
    
    //那为什么相同的代码,换成abc就不崩溃呢?
    //因为苹果的taggerPointer技术,当需要存储数据需要的内存空间很少的时候,这个时候再开辟一个对象,然后再拿一个指针去指向他,其实会造成空间的浪费,所以苹果在需要存储的数据需要的空间很少的时候,会把这个值直接存储在栈中的这个指针里边,因为不是对象,涉及不到释放的操作,所以多个线程访问时,并不会造成崩溃.
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    for (int i = 0; i < 1000; i++) {
//        dispatch_async(queue, ^{
//            self.name = [NSString stringWithFormat:@"abc"];
//        });
//    }
//    NSLog(@"end");
    
    //我们去分别打印他俩所属的类,也能看出差别
    NSString *str1 = [NSString stringWithFormat:@"abcdefghijk"];
    NSString *str2 = [NSString stringWithFormat:@"123abc"];
    NSLog(@"%@ %@", [str1 class], [str2 class]);
}


@end

