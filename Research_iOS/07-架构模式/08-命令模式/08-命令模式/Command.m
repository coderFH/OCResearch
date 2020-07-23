//
//  Command.m
//  45-命令模式
//
//  Created by wangfh on 2019/10/15.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "Command.h"
#import "CommandManager.h"

@implementation Command

- (void)execute {
    
    //override to subClass
    
    [self done];
}

- (void)cancel {
    self.completion = nil;
}

- (void)done {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_completion) {
            _completion(self);
        }
        
        //释放
        self.completion = nil;
        
        [[CommandManager sharedInstance].arrayCommands removeObject:self];
    });
}

@end
