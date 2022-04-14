//
//  ViewController.m
//  04-KVO底层
//
//  Created by wangfh on 2018/7/12.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHPerson.h"
#import <objc/runtime.h>
/*
 iOS用什么方式实现对一个对象的KVO？(KVO的本质是什么？)
    利用RuntimeAPI动态生成一个子类，并且让instance对象的isa指向这个全新的子类(object_setClass)
    当修改instance对象的属性时，会调用Foundation的_NSSetXXXValueAndNotify函数
        而_NSSetXXXValueAndNotify内部实现流程可能是
            1.willChangeValueForKey:
            2.父类原来的setter
            3.didChangeValueForKey:
            4.内部会触发监听器（Oberser）的监听方法( observeValueForKeyPath:ofObject:change:context:）

 如何手动触发KVO？
    手动调用willChangeValueForKey:和didChangeValueForKey:
 
 直接修改成员变量会触发KVO么？
    不会触发KVO
 */
@interface ViewController ()

@property (strong, nonatomic) FHPerson *person1;
@property (strong, nonatomic) FHPerson *person2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person1 = [[FHPerson alloc] init];
    self.person1.age = 10;
    
    self.person2 = [[FHPerson alloc] init];
    self.person2.age = 20;
    
    NSLog(@"person1添加KVO监听之前 - %@ %@",
          object_getClass(self.person1), //FHPerson
          object_getClass(self.person2));//FHPerson
    NSLog(@"person1添加KVO监听之前 - %p %p",
          [self.person1 methodForSelector:@selector(setAge:)],//0x101268500
          [self.person2 methodForSelector:@selector(setAge:)]);//0x101268500
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:@"111"];
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:@"111"];
    
//    //由此可见,在添加了KVO监听后,系统其实利用运行时生成了一个FHPerson的子类NSKVONotifying_FHPerson
//    NSLog(@"person1添加KVO监听之后 - %@ %@",
//          object_getClass(self.person1),//NSKVONotifying_FHPerson
//          object_getClass(self.person2));//FHPerson
//    NSLog(@"person1添加KVO监听之后 - %p %p",
//          [self.person1 methodForSelector:@selector(setAge:)], //0x10160ff8e
//          [self.person2 methodForSelector:@selector(setAge:)]);//0x101268500
//
//    //打印的是同一个对象的原因就是NSKVONotifying_FHPerson重写了Class这个方法,返回了FHPerson类,上边利用runtime打印才能真正的看出确实生成了子类
//    NSLog(@"利用[xxx class]查看%@ %@",[self.person1 class],[self.person2 class]);
//
//
//    //====== 验证直接修改成员属性,是否能触发kvo=======
//    NSKeyValueObservingOptions options1 = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//    [self.person1 addObserver:self forKeyPath:@"sex" options:options1 context:@""];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.person1.age = 20;
    
    //====== 验证直接修改成员属性,是否能触发kvo=======
//    [self.person1 willChangeValueForKey:@"sex"];
    self.person1->_sex = 1;
//    [self.person1 didChangeValueForKey:@"sex"]; //由此可知,如果不手动触发,修改成员属性是不会触发kvo的
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听到%@的%@属性值改变了 - %@ - %@", object, keyPath, change, context);
}

- (void)dealloc {
    [self.person1 removeObserver:self forKeyPath:@"age"];
}

@end

