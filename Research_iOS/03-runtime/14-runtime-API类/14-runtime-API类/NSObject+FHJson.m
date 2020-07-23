//
//  NSObject+FHJson.m
//  23-runtime-API类
//
//  Created by wangfh on 2018/8/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "NSObject+FHJson.h"
#import <objc/runtime.h>

@implementation NSObject (FHJson)

+ (instancetype)fh_objectWithJson:(NSDictionary *)json
{
    id obj = [[self alloc] init];
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        // 取出i位置的成员变量
        Ivar ivar = ivars[i];
        //转成OC字符串
        NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
        //去除下划线(_)
        [name deleteCharactersInRange:NSMakeRange(0, 1)];
        // 设值
        id value = json[name];
        if ([name isEqualToString:@"ID"]) {
            value = json[@"id"];
        }
        [obj setValue:value forKey:name];
    }
    free(ivars);
    
    return obj;
}

@end
