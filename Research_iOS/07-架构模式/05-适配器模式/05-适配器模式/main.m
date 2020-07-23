//
//  main.m
//  43-适配器模式
//
//  Created by wangfh on 2019/10/15.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoolTarget.h"
#import "Target.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CoolTarget *coolTarget = [[CoolTarget alloc] init];
        Target *target = [[Target alloc] init];
        coolTarget.target = target;
        [coolTarget request];
    }
    return 0;
}
