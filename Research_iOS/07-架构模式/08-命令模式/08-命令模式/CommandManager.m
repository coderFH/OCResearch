//
//  CommandManager.m
//  45-命令模式
//
//  Created by wangfh on 2019/10/15.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "CommandManager.h"

@implementation CommandManager

+ (id)shareInstance {
    // 静态局部变量
    static CommandManager *instance = nil;
    
    //通过dispatch_once方式 确保instance在多线程环境下只能创建一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 创建实例  不使用self的原因是会引起循环引用
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //初始化命令容器
        _arrayCommands = [NSMutableArray array];
    }
    return self;
}

+ (void)executeCommand:(Command *)cmd completion:(CommandCompletionCallBack)completion {
    if (cmd) {
        // 如果命令正在执行不做处理,否则添加并执行命令
        if ([self _isExecutingCommad:cmd]) {
            //添加到命令容器
            [[[self sharedInstance] arrayCommands] addObject:cmd];
            //设置命令执行完成的回调
            cmd.completion = completion;
            //执行命令
            [cmd execute];
        }
    }
}

+ (void)cancelCommand:(Command *)cmd {
    if (cmd) {
        //从命令容器当中移除
        [[[self sharedInstance] arrayCommands] removeObject:cmd];
        //取消命令执行
        [cmd cancel];
    }
}

+ (BOOL)_isExecutingCommad:(Command *)cmd {
    if (cmd) {
        NSArray *cmds = [[self sharedInstance] arrayCommands];
        for (Command *aCmd in cmds) {
            //当前命令正在执行
            if (cmd == aCmd) {
                return YES;
            }
        }
    }
    return NO;
}

@end
