//
//  FHPerson+Test.h
//  09-关联属性
//
//  Created by wangfh on 2018/7/18.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHPerson.h"

/*
 类别中增加属性，例如下面代码，只会增加属性weight(不会增加成员变量_weight)，并且不会自动生成get,set方法。
 */
@interface FHPerson (Test)

/*
如果分类中这么写属性,只会生成以下两个方法的声明
- (void)setWeight:(int)weight;
- (int)weight;
不会生成实现,并且不会生成一个成员变量_weight
*/
@property(nonatomic,assign) int weight;

@end
