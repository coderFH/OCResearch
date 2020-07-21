//
//  main.m
//  07-消息转发带参数的示例
//
//  Created by wangfh on 2020/7/21.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHPerson *p = [[FHPerson alloc] init];
        [p setAge:10];
    }
    return 0;
}
