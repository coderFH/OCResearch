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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

