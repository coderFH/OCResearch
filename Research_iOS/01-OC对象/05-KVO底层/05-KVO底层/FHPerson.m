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

// 这里写两个方法的原因是要验证NSKVONotifying_FHPerson内部的_NSSetIntValueAndNotify确实调用了这两个方法
- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key]; // 验证确实调用,所以super一下,如果真的NSKVONotifying_FHPerson调用了这个方法,通过父类打印出来
    NSLog(@"willChangeValueForKey");
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"didChangeValueForKey - begin");
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey - end");
}


@end
