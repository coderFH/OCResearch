//
//  main.m
//  03-搞懂isa必备知识-union
//
//  Created by wangfh on 2020/7/20.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHPerson *person = [[FHPerson alloc] init];
        person.tall = NO;
        person.rich = YES;
        person.handsome = NO;
        
        NSLog(@"thin:%d rich:%d hansome:%d", person.isTall, person.isRich, person.isHandsome);
    }
    return 0;
}
