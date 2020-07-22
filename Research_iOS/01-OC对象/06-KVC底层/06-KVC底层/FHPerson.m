//
//  FHPerson.m
//  05-KVC底层
//
//  Created by Ne on 2018/7/15.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHPerson.h"

@implementation FHPerson

/*
 valueForKey
 1.按照getKey,key,isKey,_key的顺序去查找方法 找不到会调用accessInstanceVariablesDirectly
 2.如果accessInstanceVariablesDirectly 返回NO 调用valueForUndefinedKey: 并抛出异常NSUnknownKeyException
 3.如果accessInstanceVariablesDirectly 返回YES  按照 _key、_isKey、key、isKey 顺序查找成员变量  如果找不到  调用valueForUndefinedKey: 并抛出异常NSUnknownKeyException
 */

//- (int)getAge {
//    return 11;
//}

//- (int)age {
//    return 12;
//}

//- (int)isAge {
//    return 13;
//}

//- (int)_age {
//    return 14;
//}

// 默认的返回值就是YES
//+ (BOOL)accessInstanceVariablesDirectly
//{
//    return YES;
//}

/*
 setValue:forKey
 1.按照setKey,_setKey顺序查找方法,找到了 传递参数,调用方法
 2.没找到   查看 accessInstanceVariablesDirectly 方法的返回值
 3.返回NO 调用setValue:forUndefinedKey: 并抛出异常NSUnknownKeyException
 4.返回YES 按照 _key、_isKey、key、isKey顺序查找成员变量 找到了直接赋值  找不到调用setValue:forUndefinedKey: 并抛出异常NSUnknownKeyException
*/
//- (void)setAge:(int)age {
//    NSLog(@"setAge: - %d", age);
//}

//- (void)_setAge:(int)age {
//    NSLog(@"_setAge: - %d", age);
//}

- (void)willChangeValueForKey:(NSString *)key
{
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey - %@", key);
}

- (void)didChangeValueForKey:(NSString *)key
{
    NSLog(@"didChangeValueForKey - begin - %@", key);
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey - end - %@", key);
}



@end
