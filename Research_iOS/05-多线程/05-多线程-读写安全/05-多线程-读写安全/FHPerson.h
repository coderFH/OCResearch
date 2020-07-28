//
//  FHPerson.h
//  05-多线程-读写安全
//
//  Created by wangfh on 2020/7/28.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHPerson : NSObject

@property (nonatomic, strong) NSMutableArray *array;

@end

NS_ASSUME_NONNULL_END
