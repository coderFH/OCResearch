//
//  FHAppViewModel.m
//  Interview04-MVC-Apple
//
//  Created by FH  on 2018/7/17.
//  Copyright © 2018年 FH . All rights reserved.
//

#import "FHAppViewModel.h"
#import "FHApp.h"
#import "FHAppView.h"

@interface FHAppViewModel() <FHAppViewDelegate>
@property (weak, nonatomic) UIViewController *controller;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *image;
@end

@implementation FHAppViewModel

- (instancetype)initWithController:(UIViewController *)controller
{
    if (self = [super init]) {
        self.controller = controller;
        
        // 创建View
        FHAppView *appView = [[FHAppView alloc] init];
        appView.frame = CGRectMake(100, 100, 100, 150);
        appView.delegate = self;
        appView.viewModel = self;
        [controller.view addSubview:appView];
        
        // 加载模型数据
        FHApp *app = [[FHApp alloc] init];
        app.name = @"QQ";
        app.image = @"QQ";
        
        // 设置数据
        self.name = app.name;
        self.image = app.image;
    }
    return self;
}

#pragma mark - FHAppViewDelegate
- (void)appViewDidClick:(FHAppView *)appView
{
    NSLog(@"viewModel 监听了 appView 的点击");
}

@end
