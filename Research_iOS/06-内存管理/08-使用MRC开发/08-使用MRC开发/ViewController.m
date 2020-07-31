//
//  ViewController.m
//  08-使用MRC开发
//
//  Created by wangfh on 2020/7/29.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (retain, nonatomic) NSMutableArray *data;
@property (retain, nonatomic) UITabBarController *tabBarController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.data = [NSMutableArray array];
    [self.data release];
    
//    self.data = [[[NSMutableArray alloc] init] autorelease];
    
//    self.data = [[NSMutableArray alloc] init];
//    [self.data release];
    
//    NSMutableArray *data = [[NSMutableArray alloc] init];
//    self.data = data;
//    [data release];
}

- (void)dealloc {
    self.data = nil;
    self.tabBarController = nil;
    
    [super dealloc];
}


@end
