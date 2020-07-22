//
//  main.m
//  18-runtime-msgSend
//
//  Created by wangfh on 2018/8/22.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"
#import "FHGoodPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // OC的方法调用：消息机制，给方法调用者发送消息
        // objc_msgSend如果找不到合适的方法进行调用，会报错unrecognized selector sent to instance
        
        [FHPerson initialize];
        // objc_msgSend([FHPerson class], @selector(initialize));
        // 消息接收者（receiver）：[FHPerson class]
        // 消息名称：initialize
        
#pragma mark ---- 正常的消息发送 -----
        FHPerson *person = [[FHPerson alloc] init];
        [person personTest];
        // objc_msgSend(person, @selector(personTest));
        // 消息接收者（receiver）：person
        // 消息名称：personTest
        
        // 会调用到父类的方法
        FHGoodPerson *gs = [[FHGoodPerson alloc] init];
        [gs personTest];
        
#pragma mark ---- 动态方法解析 -----
        //动态的添加类方法
        [FHPerson dongTaiFangFa];
        
        //动态的添加实例放啊
        FHPerson *p1 = [[FHPerson alloc] init];
        [p1 test];
        
#pragma mark ------ 消息转发 -----
        FHPerson *p2 = [[FHPerson alloc] init];
        [p2 xiaoXiZhuanFa];
        
        [FHPerson leiTest];
    }
    return 0;
}
