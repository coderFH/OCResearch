//
//  main.m
//  42-桥接模式
//
//  Created by wangfh on 2019/10/14.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BridgeDemo.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BridgeDemo *demo = [[BridgeDemo alloc] init];
        [demo fetch];
    }
    return 0;
}
