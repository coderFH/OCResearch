//
//  ViewController.m
//  41-责任链模式
//
//  Created by wangfh on 2019/10/14.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "BusinessObject.h"
#import "BusinessObjectA.h"
#import "BusinessObjectB.h"
#import "BusinessObjectC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BusinessObjectA *a = [[BusinessObjectA alloc] init];
    BusinessObjectB *b = [[BusinessObjectB alloc] init];
    BusinessObjectC *c = [[BusinessObjectC alloc] init];
    
    c.nextBusiness = b;
    b.nextBusiness = a;
    a.nextBusiness = nil;
    

    [c handle:^(BusinessObject * _Nullable handler, BOOL handled) {
        NSLog(@"%@ %d",handler,handled);
    }];
}


@end

