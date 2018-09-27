//
//  FHAppView.h
//  38-MVP
//
//  Created by wangfh on 2018/9/27.
//  Copyright © 2018 wangfh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FHAppView;

@protocol FHAppViewDelegate <NSObject>

@optional
- (void)appViewDidClick:(FHAppView *)appView;

@end

@interface FHAppView : UIView

- (void)setName:(NSString *)name andImage:(NSString *)image;

@property (weak, nonatomic) id<FHAppViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
