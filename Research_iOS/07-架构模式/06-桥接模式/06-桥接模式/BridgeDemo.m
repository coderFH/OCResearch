//
//  BridgeDemo.m
//  42-桥接模式
//
//  Created by wangfh on 2019/10/15.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "BridgeDemo.h"
#import "BaseObjectA.h"
#import "ObjectA1.h"
#import "ObjectB1.h"

@interface BridgeDemo()

@property(nonatomic, strong) BaseObjectA *objA;

@end

@implementation BridgeDemo

- (void)fetch {
    //创建一个具体的ClassA
    _objA = [[ObjectA1 alloc] init];
    
    //创建一个具体的ClassB
    BaseObjectB *b1 = [[ObjectB1 alloc] init];
    _objA.objB = b1;
    
    //获取数据
    [_objA handle];
}

@end
