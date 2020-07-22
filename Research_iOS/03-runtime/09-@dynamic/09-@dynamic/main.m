//
//  main.m
//  19-runtime-@dynamic
//
//  Created by wangfh on 2018/8/23.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHPerson *person = [[FHPerson alloc] init];
        person.age = 20;
        
        NSLog(@"%d", person.age);
    }
    return 0;
}
