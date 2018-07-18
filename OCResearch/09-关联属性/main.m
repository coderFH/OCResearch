//
//  main.m
//  09-关联属性
//
//  Created by wangfh on 2018/7/18.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"
#import <objc/runtime.h>
#import "FHPerson+Test.h"

/** 获取成员变量列表*/
void getIvarName(Class cls) {
    unsigned int count = 0;
    
    //拷贝出所有的成员变量的列表
    Ivar *ivars =class_copyIvarList(cls, &count);
    for (int i =0; i<count; i++) {
        //取出成员变量
        Ivar var = *(ivars + i);
        //打印成员变量名字
        NSLog(@"%s",ivar_getName(var));
    }
    //释放
    free(ivars);
}

void printMethodNamesOfClass(Class cls) {
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        // 拼接方法名
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    // 释放
    free(methodList);
    // 打印方法名
    NSLog(@"%@", methodNames);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHPerson *person = [[FHPerson alloc] init];
        person.age = 10;
        person.weight = 20;
        NSLog(@"%d %d",person.age,person.weight);
        
        getIvarName([person class]);
        printMethodNamesOfClass([person class]);
    }
    return 0;
}


