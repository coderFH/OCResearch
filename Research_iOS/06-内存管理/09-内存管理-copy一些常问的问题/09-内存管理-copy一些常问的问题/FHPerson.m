//
//  FHPerson.m
//  09-内存管理-copy一些常问的问题
//
//  Created by wangfh on 2020/7/30.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import "FHPerson.h"

@implementation FHPerson

@synthesize data = _data;
- (void)setName:(NSString *)name {
    if (_name != name) {
        [_name release];
        _name = [name retain];
    }
}

- (void)setData:(NSArray *)data {
    if (_data != data) {
        [_data release];
        _data = [data copy];
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
    [super dealloc];
}
@end
