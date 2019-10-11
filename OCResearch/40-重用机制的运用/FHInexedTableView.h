//
//  FHInexedTableView.h
//  40-重用机制的运用
//
//  Created by wangfh on 2019/10/11.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexTableViewDataSource <NSObject>

/// 获取一个tableview的字母索引条数据方法
- (NSArray<NSString *> *_Nonnull)indexTitlesForIndexTableView:(UITableView *_Nonnull)tableView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface FHInexedTableView : UITableView

@property(nonatomic, weak) id<IndexTableViewDataSource> indexedDataSource;

@end

NS_ASSUME_NONNULL_END
