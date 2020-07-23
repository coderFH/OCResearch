//
//  main.m
//  45-命令模式
//
//  Created by wangfh on 2019/10/15.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentCmd.h"
#import "relayCmd.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CommentCmd *comment = [[CommentCmd alloc] init];
        [comment execute];
        
        relayCmd *relay = [[relayCmd alloc] init];
        [relay execute];
    }
    return 0;
}
