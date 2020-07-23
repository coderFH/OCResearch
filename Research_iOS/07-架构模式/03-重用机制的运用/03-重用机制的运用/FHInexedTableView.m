//
//  FHInexedTableView.m
//  40-重用机制的运用
//
//  Created by wangfh on 2019/10/11.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "FHInexedTableView.h"
#import "FHViewReusePool.h"

@interface FHInexedTableView()
{
    UIView *containerView;
    FHViewReusePool *reusePool;
}
@end

@implementation FHInexedTableView

- (void)reloadData {
    [super reloadData];
    // 懒加载
    if (containerView == nil) {
        containerView = [[UIView alloc] initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor whiteColor];
        
        //避免索引条随着table滚动
        [self.superview insertSubview:containerView aboveSubview:self];
    }
    if (reusePool == nil) {
        reusePool = [[FHViewReusePool alloc] init];
    }
    
    //标记所有视图为可重用状态
    [reusePool reset];
    
    //reload字母索引条
    [self reloadIndexedBar];
}

- (void)reloadIndexedBar {
    //获取字母索引条的显示内容
    NSArray<NSString *> *arrayTitles = nil;
    if ([self.indexedDataSource respondsToSelector:@selector(indexTitlesForIndexTableView:)]) {
        arrayTitles = [self.indexedDataSource indexTitlesForIndexTableView:self];
    }
    //判断字母索引条是否为空
    if (!arrayTitles || arrayTitles.count <= 0) {
        [containerView setHidden:YES];
        return;
    }
    NSUInteger count = arrayTitles.count;
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = self.frame.size.height / count;
    
    for (int i = 0; i < [arrayTitles count]; i++) {
        NSString *title = [arrayTitles objectAtIndex:i];
        
        //从重用池中取出一个button
        UIButton *button = (UIButton *)[reusePool dequeReusableView];
        //如果没有可重用的Button重新创建一个
        if (button == nil) {
            button = [[UIButton alloc] initWithFrame:CGRectZero];
            button.backgroundColor = [UIColor whiteColor];
            
            //注册button到重用池当中
            [reusePool addUsingView:button];
            NSLog(@"新创建一个button");
        } else {
            NSLog(@"button 重用了");
        }
        
        //添加button到父控件
        [containerView addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置button的坐标
        [button setFrame:CGRectMake(0 , i * buttonHeight, buttonWidth, buttonHeight)];
    }
    [containerView setHidden:NO];
    containerView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - buttonWidth, self.frame.origin.y, buttonWidth, self.frame.size.height);
}

@end
