//
//  FHPerson+Test.m
//  09-关联属性
//
//  Created by wangfh on 2018/7/18.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHPerson+Test.h"
#import <objc/runtime.h>

@implementation FHPerson (Test)

- (void)setWeight:(int)weight {
    //self:给哪个类添加
    //key值,使用@selector(weight),本质也是取一个方法的地址值来作为key
    //给哪个属性添加
    //保存的策略,类似strong,assgin等
    objc_setAssociatedObject(self, @selector(weight), @(weight), OBJC_ASSOCIATION_ASSIGN);
}

//其实这里会传两个参数 一个是self, 一个是_cmd 指向本方法的指针,通过隐士参数传递的
- (int)weight {
    //这里的_cmd == @selector(weight)
    //如果在  - (void)setWeight:(int)weight 方法里的第二个参数使用 _cmd
    //那么这里就得用@selector(setWeight:)
    //_cmd是一个隐士参数
    return [objc_getAssociatedObject(self, _cmd) intValue];
}

@end
