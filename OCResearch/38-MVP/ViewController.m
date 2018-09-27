//
//  ViewController.m
//  38-MVP
//
//  Created by wangfh on 2018/9/27.
//  Copyright © 2018 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHAppPresenter.h"

@interface ViewController ()

@property (strong, nonatomic) FHAppPresenter *presenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[FHAppPresenter alloc] initWithController:self];
}


@end
