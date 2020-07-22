//
//  FHPerson.m
//  10-block的变量捕获
//
//  Created by wangfh on 2019/10/17.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "FHPerson.h"

@implementation FHPerson

//test 会默认传递过来两个参数(FHPerson *self,SEL _cmd)
- (void)test {
    //这里的self也会被block捕获,因为self其实也是局部变量
    void (^block)(void) = ^ {
        NSLog(@"%p",self);
    };
    block();
}

@end
