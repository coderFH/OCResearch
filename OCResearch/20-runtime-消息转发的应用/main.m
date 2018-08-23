//
//  main.m
//  20-runtime-消息转发的应用
//
//  Created by wangfh on 2018/8/23.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHPerson *person = [[FHPerson alloc] init];
        [person run];
        [person test];
        [person other];
    }
    return 0;
}
