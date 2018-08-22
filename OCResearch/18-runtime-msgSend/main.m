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
        
        FHPerson *person = [[FHPerson alloc] init];
        [person personTest];
        // objc_msgSend(person, @selector(personTest));
        // 消息接收者（receiver）：person
        // 消息名称：personTest
        
        FHGoodPerson *gs = [[FHGoodPerson alloc] init];
        [gs personTest];
        
        //================动态方法解析================
        [FHPerson dongTaiFangFa];
        
        
       
    }
    return 0;
}
