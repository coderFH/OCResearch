//
//  FHAppPresenter.m
//  38-MVP
//
//  Created by wangfh on 2018/9/27.
//  Copyright © 2018 wangfh. All rights reserved.
//

#import "FHAppPresenter.h"
#import "FHApp.h"
#import "FHAppView.h"

@interface FHAppPresenter()<FHAppViewDelegate>

@property (weak, nonatomic) UIViewController *controller;

@end

@implementation FHAppPresenter

- (instancetype)initWithController:(UIViewController *)controller {
    if (self = [super init]) {
        self.controller = controller;
        
        // 创建View
        FHAppView *appView = [[FHAppView alloc] init];
        appView.frame = CGRectMake(100, 100, 100, 150);
        appView.delegate = self;
        [controller.view addSubview:appView];
        
        // 加载模型数据
        FHApp *app = [[FHApp alloc] init];
        app.name = @"QQ";
        app.image = @"QQ";
        
        // 赋值数据
        [appView setName:app.name andImage:app.image];
    }
    return self;
}

#pragma mark - MJAppViewDelegate
- (void)appViewDidClick:(FHAppView *)appView {
    NSLog(@"presenter 监听了 appView 的点击");
}

@end
