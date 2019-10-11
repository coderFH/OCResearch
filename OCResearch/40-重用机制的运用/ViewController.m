//
//  ViewController.m
//  40-重用机制的运用
//
//  Created by wangfh on 2019/10/11.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "ViewController.h"
#import "FHInexedTableView.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource,IndexTableViewDataSource>
{
    FHInexedTableView *tableView; //带有索引条的tableview
    UIButton *button;
    NSMutableArray *dataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个tablview
    tableView = [[FHInexedTableView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //设置table的索引数据源
    tableView.indexedDataSource = self;
    
    [self.view addSubview:tableView];
    
    //创建一个按钮
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"reloadTable" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    //数据源
    dataSource = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [dataSource addObject:@(i+1)];
    }
}

- (NSArray<NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView {
    //奇数次调用返回6个字母,欧数次返回11个
    static BOOL change = NO;
    if (change) {
        change = NO;
        return @[@"a",@"b",@"c"];
    } else {
        change = YES;
        return @[@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5"];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"reuseId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [[dataSource objectAtIndex:indexPath.row] stringValue];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)doAction {
    [tableView reloadData];
}

@end
