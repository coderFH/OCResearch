//
//  ViewController.m
//  13-一道面试题
//
//  Created by wangfh on 2020/7/22.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import "ViewController.h"

@interface FHPerson : NSObject

@property (nonatomic, copy) NSString *name;

- (void)print;

@end

@implementation FHPerson

- (void)print {
    NSLog(@"my name is %@",self.name);
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id cls = [FHPerson class];
    void *obj = &cls;
    [(__bridge id)obj print];
}

/*
上边的案例能否编译通过? 如果可以,打印的结果是什么
题解:
 首先
    id cls = [FHPerson class];
    void *obj = &cls;
    [(__bridge id)obj print];
 和
    FHPerson *p = [[FHPerson alloc] init];
    [p print];
 对于调用print的区别是什么?
 对于第一种写法: 内存结构的示意图 obj->cls->Person的类对象
 对于第二种写法: 内存结构的示意图 p->isa->Person的类对象 (因为p是通过自身的isa去找到自己的类对象)
 
 所以这个题是想把obj当成p,cls当成isa,这么去理解的话,首先肯定是可以编译通过的
 
 再看打印结果的事,为什么会打印出 my name is <ViewController: 0x7fdef880aa00>
 首先要了解堆栈问题?
    1. 在函数中,栈空间数据的存放是从高地址到低地址,所以第一句有一个[super viewDidLoad]
    而[super viewDidLoad]的底层实现是
        struct abc = struct {self,ViewController}
        objc_msgsendSuper2(abc,sel_registerName("viewDidLoad"))
    2. 因为是最先调用,所以在栈空间中,就有了abc这个结构体(self,ViewController)
    3. 然后往下走 是cls最后是obj
    4. 所以栈空间存放从低地址->高地址就是 obj-cls-self\ViewController
    5. 因为把obj当成了p使用,在调用[(__bridge id)obj print] 时 走到 NSLog(@"my name is %@",self.name);
       如果类比成p调用_name,其实是偏移8个字节(就是跳过isa),然后取自己的成员变量_name
       同样obj 偏移8个字节 也就是略过cls  就会走到abc这个结构体中的self.
    6. 而self是就是当前控制器,他就会把控制器当成了_name,所以最终的打印就是 my name is <ViewController: 0x7fdef880aa00>
*/

@end
