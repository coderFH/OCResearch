//
//  CoolTarget.m
//  43-适配器模式
//
//  Created by wangfh on 2019/10/15.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "CoolTarget.h"

@implementation CoolTarget

- (void)request {
    // 额外处理
    NSLog(@"11111");
    
    [self.target operation];
    
    //额外处理
    NSLog(@"2222");
}
@end
