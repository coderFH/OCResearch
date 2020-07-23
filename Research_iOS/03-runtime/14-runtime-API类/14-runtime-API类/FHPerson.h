//
//  FHPerson.h
//  23-runtime-API类
//
//  Created by wangfh on 2018/8/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHPerson : NSObject

@property (nonatomic,assign) int age;
@property (nonatomic,copy) NSString *name;

- (void)run;

@end
