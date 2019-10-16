//
//  Command.h
//  45-命令模式
//
//  Created by wangfh on 2019/10/15.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Command;
typedef void(^CommandCompletionCallBack)(Command * _Nullable cmd);

NS_ASSUME_NONNULL_BEGIN

@interface Command : NSObject

@property(nonatomic, copy) CommandCompletionCallBack completion;

- (void)execute;
- (void)cancel;

- (void)done;

@end

NS_ASSUME_NONNULL_END
