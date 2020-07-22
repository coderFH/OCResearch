//
//  ViewController.m
//  06-selector和typeEncoding
//
//  Created by wangfh on 2020/7/20.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     methods的结构
     struce method_t {
        SEL name;           //函数名
        const char *types;  //编码(返回值类型,参数类型)
        IMP imp;            // 指向函数的指针(函数地址)
     }
     */
    
    
    // SEL就可以理解为函数名/方法名
    SEL se1 = @selector(alloc);
    SEL se2 = @selector(init);

    //将SEL转化成字符串
    NSLog(@"%s %@",sel_getName(se1),NSStringFromSelector(se2));

    //不同类中,相同名字的方法,所对应的选择器是相同的
    [self performSelector:@selector(ceshi)];
    FHPerson *p = [[FHPerson alloc] init];
    [p performSelector:@selector(ceshi)];
    
    
    //methods中 types的意思
    // typeEncoding
    // 最终解析的样子是,具体看FHPerson.h
    // "i24@0:8i16f20"
    [p test:10 height:20];
}

- (void)ceshi {
    NSLog(@"1111");
}


@end
