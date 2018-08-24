//
//  ViewController.m
//  25-runtime-交换方法的案例
//
//  Created by wangfh on 2018/8/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark --当可变数组中添加nil对象时
    NSString *obj = nil;
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"jack"];
    [array insertObject:obj atIndex:0];
    NSLog(@"%@",array);

#pragma mark --当可变字典中存nil对象时
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"name"] = @"jack";
    dict[obj] = @"rose"; //key值不能是空
    dict[@"age"] = obj; //value可以是空
    NSLog(@"%@", dict);
    
#pragma mark --当不可变字典通过空key取值
    NSDictionary *dict1 = @{@"name" : [[NSObject alloc] init],
                           @"age" : @"jack"};
    NSString *value =  dict1[obj];
    NSLog(@"%@", [dict1 class]);
}

#pragma mark--我想拦截每个按钮的点击
- (IBAction)btn1Click:(id)sender {
     NSLog(@"%s", __func__);
}
- (IBAction)btn2Click:(id)sender {
     NSLog(@"%s", __func__);
}
- (IBAction)btn3Click:(id)sender {
     NSLog(@"%s", __func__);
}


@end
