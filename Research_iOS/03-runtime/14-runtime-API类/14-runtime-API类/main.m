//
//  main.m
//  23-runtime-API类
//
//  Created by wangfh on 2018/8/24.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"
#import "FHCar.h"
#import <objc/runtime.h>
#import "NSObject+FHJson.h"

void run(id self,SEL _cmd) {
    NSLog(@"%@ %@",self,NSStringFromSelector(_cmd));
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHPerson *person = [[FHPerson alloc] init];
        //==========================object_getClass(),获取实例对象isa所指向的类对象==========================
        NSLog(@"%p %p",object_getClass(person),[person class]);
        
        //==========================object_setClass(),修改实例对象isa所指向的实例对象==========================
        [person run];// -[FHPerson run]
        object_setClass(person, [FHCar class]);
        [person run];//-[FHCar run]
        
        //==========================object_isClass(),判读是否是类对象(元类对象也是一种特殊的类对象)==========================
        NSLog(@"%d %d %d", object_isClass(person),
                           object_isClass([FHPerson class]),
                           object_isClass(object_getClass([FHPerson class])));
        
        //==========================动态创建一个类==========================
        //创建类
        Class newClasss =  objc_allocateClassPair([NSObject class], "FHDog", 0);
        //添加成员变量
        //4:这个变量占多少字节
        //1:是内存对齐,传1就行
        class_addIvar(newClasss, "_age", 4, 1, @encode(int));
        class_addIvar(newClasss, "_weight", 4, 1, @encode(int));
        //添加方法
        class_addMethod(newClasss, @selector(run), (IMP)run, "v@:");
        //注册类
        objc_registerClassPair(newClasss);
        id dog = [[newClasss alloc] init];
        //占多少字节
        NSLog(@"%zd",class_getInstanceSize(newClasss));
        
        NSLog(@"%@",[dog class]);
        [dog setValue:@10 forKey:@"_age"];
        [dog setValue:@20 forKey:@"_weight"];
        NSLog(@"%@ %@",[dog valueForKey:@"_age"],[dog valueForKey:@"_weight"]);
        [dog run];
        
        // //在不需要这个类的时候释放
        // objc_disposeClassPair(newClasss);
        
        NSLog(@"==========================成员变量==========================");
        //获取成员变量信息
        Ivar ageIvar = class_getInstanceVariable([FHPerson class], "_age");
        NSLog(@"%s %s",ivar_getName(ageIvar),ivar_getTypeEncoding(ageIvar));
        
        //设置和获取成员变量的值
        Ivar nameIvar = class_getInstanceVariable([FHPerson class], "_name");
        FHPerson *p1 = [[FHPerson alloc] init];
        object_setIvar(p1, nameIvar, @"123");
        NSLog(@"%@ %@",p1.name,object_getIvar(p1, nameIvar));
        
        //获取一个类的所有成员变量
        unsigned int count;//成员变量的数量
        Ivar *ivars = class_copyIvarList([FHPerson class], &count);
        for (int i = 0; i < count; i++) {
            //取出i位置的成员变量
            Ivar ivar = ivars[i];
            NSLog(@"%s %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
        }
        free(ivars);
        
        //==========================class_copyIvarList的应用==========================
        /*
            可以遍历出UITextField所有成员变量,发现显示占位文字的是_placeholderLabel,然后去修改它占位文字的颜色
            self.textField.placeholder = @"请输入用户名";
            [self.textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        */
        
        //字典转模型
        NSDictionary *json = @{@"age" : @20,@"name" : @"Jack"};
        FHPerson *p3= [FHPerson fh_objectWithJson:json];
        NSLog(@"%@ %d",p3.name,p3.age);
    }
    return 0;
}


