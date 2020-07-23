//
//  BaseObjectA.m
//  42-适配器模式
//
//  Created by wangfh on 2019/10/14.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "BaseObjectA.h"

@implementation BaseObjectA

- (void)handle {
    [self.objB fetchData];
}

@end
