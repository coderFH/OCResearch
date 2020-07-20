//
//  FHPerson.h
//  06-selector和typeEncoding
//
//  Created by wangfh on 2020/7/20.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHPerson : NSObject

- (void)ceshi;

/*
 typeEncoding
 字母表示的意思?
     i 表示返回int
     @ 表示第一个参数 即self 是id类型
     : 表示第二个参数 即SEL
     i 表示第三个参数 int
     f 表示第四个参数 float
 具体数字表示的意思?
    24 表示所有参数一共占多少字节  8 + 8 + 4 + 4 = 24
    0 表示第一个参数从0开始
    8  表示第二个参数从8开始   因为第一个参数占了8个字节
    16 表示第三个参数从16开始  因为第一第二个参数8+8=16
    20 表示第四个参数从20开始  因为第一第二第三个参数8+8+4=20
 */
// "i24@0:8i16f20"
// 0id 8SEL 16int 20float  == 24
- (int)test:(int)age height:(float)height;

@end

NS_ASSUME_NONNULL_END
