//
//  FHPerson.m
//  16-block循环引用
//
//  Created by wangfh on 2018/8/3.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHPerson.h"

@implementation FHPerson

-(void)dealloc {
    NSLog(@"%s", __func__);
}

@end
