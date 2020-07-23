//
//  ViewController.m
//  39-MVVM
//
//  Created by wangfh on 2018/9/27.
//  Copyright © 2018 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHAppViewModel.h"

@interface ViewController ()

@property (strong, nonatomic) FHAppViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[FHAppViewModel alloc] initWithController:self];
}


@end
