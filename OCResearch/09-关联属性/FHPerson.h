//
//  FHPerson.h
//  09-关联属性
//
//  Created by wangfh on 2018/7/18.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 1、类中增加属性, 例如下面代码，系统会做4件事情，
    1）增加成员变量_age;
    2)属性age，
    3）setAge方法，
    4）age方法
*/

@interface FHPerson : NSObject

@property(nonatomic,assign) int age;

@end
