//
//  ViewController.m
//  37-内存管理-__weak原理
//
//  Created by wangfh on 2019/10/31.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHPerson.h"

@interface ViewController ()
/*
 根据当前对象的地址值通过哈希查找,找到对应的引用计数和弱引用,然后把弱引用清除掉
 将一些弱引用存储在哈希表中,对象要销毁的时候,就会取出我们当前对象对应的弱引用表,把弱引用表里存储的那些弱引用都给清除掉
 */
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __strong FHPerson *person1; // 默认就是强指向
    __weak FHPerson *person2;
    __unsafe_unretained FHPerson *person3;
    NSLog(@"111111");
    {
        FHPerson *person = [[FHPerson alloc] init];
//        person1 = person;
        person2 = person;
        person3 = person;
    }
    NSLog(@"222--- %@",person2);
//    NSLog(@"222--- %@",person3);//__unsafe_unretained会造成坏内存访问
}


@end
