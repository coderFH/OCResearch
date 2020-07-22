//
//  ViewController.m
//  05-KVC底层
//
//  Created by Ne on 2018/7/15.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHPerson.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic, strong) FHPerson *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[FHPerson alloc] init];
    NSLog(@"%@",object_getClass(self.person));
    [self.person setValue:@(10) forKey:@"age"];
    [self.person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    NSLog(@"%@",object_getClass(self.person));//NSKVONotifying_FHPerson
    NSLog(@"%@",[self.person valueForKey:@"age"]);//valueForKey取值的时候,会按照getKey,key,isKey,_key的顺序去查找
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.person setValue:@(20) forKey:@"age"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
     NSLog(@"监听到%@的%@属性值改变了 - %@ - %@", object, keyPath, change, context);
}

- (void)dealloc {
    // 移除KVO监听
    [self.person removeObserver:self forKeyPath:@"age"];
    
}

@end

