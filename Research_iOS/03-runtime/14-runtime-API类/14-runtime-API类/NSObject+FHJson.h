//
//  NSObject+FHJson.h
//  23-runtime-API类
//
//  Created by wangfh on 2018/8/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FHJson)

+ (instancetype)fh_objectWithJson:(NSDictionary *)json;

@end
