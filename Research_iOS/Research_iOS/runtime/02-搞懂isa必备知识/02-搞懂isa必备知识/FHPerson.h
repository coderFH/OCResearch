//
//  FHPerson.h
//  01-搞懂isa必备知识
//
//  Created by wangfh on 2020/7/20.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHPerson : NSObject

/*
 第一个项目中,虽然实现了一个字节存储,但是可读性差
 所以可以使用位域技术来解决
*/
- (void)setTall:(BOOL)tall;
- (void)setRich:(BOOL)rich;
- (void)setHandsome:(BOOL)handsome;

- (BOOL)isTall;
- (BOOL)isRich;
- (BOOL)isHandsome;

@end

NS_ASSUME_NONNULL_END
