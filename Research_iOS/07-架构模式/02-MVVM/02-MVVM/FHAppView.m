//
//  FHAppView.m
//  测试架构
//
//  Created by FH  on 2018/7/13.
//  Copyright © 2018年 FH . All rights reserved.
//

#import "FHAppView.h"
#import "NSObject+FBKVOController.h"

@interface FHAppView()
@property (weak, nonatomic) UIImageView *iconView;
@property (weak, nonatomic) UILabel *nameLabel;
@end

@implementation FHAppView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.frame = CGRectMake(0, 0, 100, 100);
        [self addSubview:iconView];
        _iconView = iconView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(0, 100, 100, 30);
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return self;
}

- (void)setViewModel:(FHAppViewModel *)viewModel
{
    _viewModel = viewModel;
    
    __weak typeof(self) waekSelf = self;
    [self.KVOController observe:viewModel keyPath:@"name" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        waekSelf.nameLabel.text = change[NSKeyValueChangeNewKey];
    }];

    [self.KVOController observe:viewModel keyPath:@"image" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        waekSelf.iconView.image = [UIImage imageNamed:change[NSKeyValueChangeNewKey]];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(appViewDidClick:)]) {
        [self.delegate appViewDidClick:self];
    }
}

@end
