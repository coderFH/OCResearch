//
//  ViewController.m
//  14-block-对象auto的测试
//
//  Created by wangfh on 2018/7/25.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHPerson.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)btnClick:(id)sender {
    FHPerson *p = [[FHPerson alloc] init];
    
    __weak FHPerson *weakP = p;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"1-------%@", weakP);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"2-------%@", p);
        });
    });
    NSLog(@"Began1");
}

- (IBAction)btnClick2:(id)sender {
    FHPerson *p = [[FHPerson alloc] init];
    
    __weak FHPerson *weakP = p;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"1-------%@", p);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"2-------%@", weakP);
        });
    });
    NSLog(@"Began2");
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
