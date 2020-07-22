//
//  ViewController.m
//  16-block循环引用
//
//  Created by wangfh on 2018/8/3.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FHPerson *per = [[FHPerson alloc] init];
    per.name = @"FH";
    //因为 Person 对象是用__strong修饰的,所以此时 __Block_Object_Assign方法内部会自动产生一个【强引用】指向
    //        per.dosomethingBlock = ^{
    //            NSLog(@"_______%@",per.name);
    //        };
    //通常的做法是创建一个 __weak 修饰的弱引用 指向 person对象
    __weak typeof(FHPerson) *weakPerson = per;
    per.dosomethingBlock = ^{
        NSLog(@"-----------%@", weakPerson.name);
    };
    
    //Block的嵌套
    FHPerson *person = [[FHPerson alloc] init];
    person.name = @"Jack";
    __weak typeof(FHPerson) *weakPer = person;
    //当 Block 被执行的时候立马打印了 beign-------信息,然后紧接着 Person对象被销毁, 3秒以后打印了 after-------信息,注意因为此时 Person对象已经被销毁了,所以打印出了 Null
    person.dosomethingBlock = ^{
        NSLog(@"beign-------");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"after-----------%@", weakPer.name);
        });
    };
    //所以 在延迟执行的Block内部 为了保住 Person对象不被销毁 我们需要使用一个强引用来保住 Person对象的命
    person.dosomethingBlock();
    
    //在延迟执行的Block内部 为了保住 Person对象不被销毁 我们需要使用一个强引用来保住 Person对象的命,
    FHPerson *person1 = [[FHPerson alloc] init];
    person1.name = @"Jack";
    __weak typeof(FHPerson) *weakPer1 = person1;
    //当 Block 被执行的时候立马打印了 beign-------信息,然后紧接着 Person对象被销毁, 3秒以后打印了 after-------信息,注意因为此时 Person对象已经被销毁了,所以打印出了 Null
    person1.dosomethingBlock = ^{
        NSLog(@"beign-------");
        FHPerson *strongPerson = weakPer1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"after-----------%@", strongPerson.name);
        });
    };
    //所以 在延迟执行的Block内部 为了保住 Person对象不被销毁 我们需要使用一个强引用来保住 Person对象的命
    person1.dosomethingBlock();

}

@end

