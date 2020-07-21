//
//  FHPerson.h
//  19-runtime-@dynamic
//
//  Created by wangfh on 2018/8/23.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHPerson : NSObject

//这句话的作用其实生成,_age的成员变量,- (void)setAge:(int)age; - (int)age;的声明和实现
@property (nonatomic, assign) int age;


@end
