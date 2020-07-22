//
//  FHPerson.h
//  16-block循环引用
//
//  Created by wangfh on 2018/8/3.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHPerson : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *name;

/** block */
@property (nonatomic, copy) void (^dosomethingBlock)();

@end
