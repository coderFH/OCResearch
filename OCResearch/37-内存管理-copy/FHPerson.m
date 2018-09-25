//
//  FHPerson.m
//  37-内存管理-copy
//
//  Created by wangfh on 2018/9/25.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHPerson.h"

@implementation FHPerson

- (id)copyWithZone:(NSZone *)zone {
    FHPerson *person = [[FHPerson allocWithZone:zone] init];
    person.age = self.age;
    person.weight = self.weight;
    return person;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"age = %d, weight = %f", self.age, self.weight];
}

@end
