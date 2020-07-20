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
 需求: 给定一个FHPerson对象,有三个属性,tall.rich,handsome,如何处理使FHPerson占据最少的空间
 */

//1.正常操作的情况: 这种方法并不能使对象尽可能少的占据空间
/*
 @property (assign, nonatomic, getter=isTall) BOOL tall;
 @property (assign, nonatomic, getter=isRich) BOOL rich;
 @property (assign, nonatomic, getter=isHansome) BOOL handsome;
 */


//2.针对以上的问题,我们可以用一个字节的一个位去表示 tall,rich,handsome,这样一个字节就解决了存放3个成员变量
- (void)setTall:(BOOL)tall;
- (void)setRich:(BOOL)rich;
- (void)setHandsome:(BOOL)handsome;

- (BOOL)isTall;
- (BOOL)isRich;
- (BOOL)isHandsome;

@end

NS_ASSUME_NONNULL_END
