//
//  FHPerson.h
//  09-内存管理-copy一些常问的问题
//
//  Created by wangfh on 2020/7/30.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHPerson : NSObject

@property (nonatomic, retain) NSString *name;

@property (nonatomic, copy) NSMutableArray *data;

@end

NS_ASSUME_NONNULL_END
