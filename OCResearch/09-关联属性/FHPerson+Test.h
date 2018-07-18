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

@property(nonatomic,assign) int weight;

@end
