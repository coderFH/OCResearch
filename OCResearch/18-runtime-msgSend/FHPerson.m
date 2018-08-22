//
//  FHPerson.m
//  18-runtime-msgSend
//
//  Created by wangfh on 2018/8/22.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHPerson.h"
#import <objc/runtime.h>

@implementation FHPerson

- (void)personTest {
    NSLog(@"%s", __func__);
}

void c_other(id self, SEL _cmd)
{
    NSLog(@"c_other - %@ - %@", self, NSStringFromSelector(_cmd));
}

//动态的去添加方法
+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(dongTaiFangFa)) {
        // 第一个参数是object_getClass(self)
        class_addMethod(object_getClass(self), sel, (IMP)c_other, "v16@0:8");
        return YES;
    }
    return [super resolveClassMethod:sel];
}


@end
