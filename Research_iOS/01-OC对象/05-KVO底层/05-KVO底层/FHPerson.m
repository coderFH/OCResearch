//
//  FHPerson.m
//  04-KVO
//
//  Created by wangfh on 2018/7/12.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHPerson.h"

@implementation FHPerson

- (void)setAge:(int)age {
    _age = age;
    NSLog(@"setAge:");
}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey");
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"didChangeValueForKey - begin");
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey - end");
    
}
@end
