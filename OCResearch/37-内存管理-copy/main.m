//
//  main.m
//  37-内存管理-copy
//
//  Created by wangfh on 2018/9/25.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"

// 拷贝的目的：产生一个副本对象，跟源对象互不影响
// 修改了源对象，不会影响副本对象
// 修改了副本对象，不会影响源对象

/*
 iOS提供了2个拷贝方法
 1.copy，不可变拷贝，产生不可变副本
 
 2.mutableCopy，可变拷贝，产生可变副本
 
 深拷贝和浅拷贝
 1.深拷贝：内容拷贝，产生新的对象
 2.浅拷贝：指针拷贝，没有产生新的对象
 */

//总结:不可变对象,调用copy,就是浅拷贝,其他都是深拷贝

#pragma mark -字符串
void test(){
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"test111111111"];
    NSString *str2 = [str1 copy]; //深拷贝
    NSMutableString *str3 = [str1 mutableCopy];//深拷贝
    NSLog(@"%@ %@ %@",str1,str2,str3);
    NSLog(@"%p %p %p",str1,str2,str3);
}

void test2() {
    NSString *str1 = [[NSString alloc] initWithFormat:@"test111111111"];
    NSString *str2 = [str1 copy]; // 浅拷贝，指针拷贝，没有产生新对象
    NSMutableString *str3 = [str1 mutableCopy]; // 深拷贝，内容拷贝，有产生新对象
    
    NSLog(@"%@ %@ %@", str1, str2, str3);
    NSLog(@"%p %p %p", str1, str2, str3);
}

#pragma mark --数组
void test4() {
    NSArray *array1 = [[NSArray alloc] initWithObjects:@"a", @"b", nil];
    NSArray *array2 = [array1 copy]; // 浅拷贝
    NSMutableArray *array3 = [array1 mutableCopy]; // 深拷贝
    
    NSLog(@"%p %p %p", array1, array2, array3);
}

void test5() {
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:@"a", @"b", nil];
    NSArray *array2 = [array1 copy]; // 深拷贝
    NSMutableArray *array3 = [array1 mutableCopy]; // 深拷贝
    
    NSLog(@"%p %p %p", array1, array2, array3);
}

#pragma mark --字典
void test6() {
    NSDictionary *dict1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"jack", @"name", nil];
    NSDictionary *dict2 = [dict1 copy]; // 浅拷贝
    NSMutableDictionary *dict3 = [dict1 mutableCopy]; // 深拷贝
    
    NSLog(@"%p %p %p", dict1, dict2, dict3);
}

void test7() {
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"jack", @"name", nil];
    NSDictionary *dict2 = [dict1 copy]; // 深拷贝
    NSMutableDictionary *dict3 = [dict1 mutableCopy]; // 深拷贝
    
    NSLog(@"%p %p %p", dict1, dict2, dict3);
}

#pragma mark --自定义copy
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test6();
        
        FHPerson *p1 = [[FHPerson alloc] init];
        p1.age = 20;
        p1.weight = 50;
        
        FHPerson *p2 = [p1 copy];
        p2.age = 30;
        
        NSLog(@"%@", p1);
        NSLog(@"%@", p2);
        
    }
    return 0;
}
