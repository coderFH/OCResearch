//
//  FHPerson.m
//  37-内存管理-__weak原理
//
//  Created by wangfh on 2019/10/31.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "FHPerson.h"

@implementation FHPerson

- (void)dealloc {
    NSLog(@"%s",__func__);
}
@end
