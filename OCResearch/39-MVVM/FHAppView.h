//
//  FHAppView.h
//  测试架构
//
//  Created by FH  on 2018/7/13.
//  Copyright © 2018年 FH . All rights reserved.
//

#import <UIKit/UIKit.h>

@class FHAppView, FHAppViewModel;

@protocol FHAppViewDelegate <NSObject>
@optional
- (void)appViewDidClick:(FHAppView *)appView;
@end

@interface FHAppView : UIView
@property (weak, nonatomic) FHAppViewModel *viewModel;
@property (weak, nonatomic) id<FHAppViewDelegate> delegate;
@end
