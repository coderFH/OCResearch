//
//  main.m
//  10-内存管理-autorelease
//
//  Created by wangfh on 2020/7/31.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHPerson : NSObject

@end

@implementation FHPerson

@end

//苹果暴露给开发者的一个私有函数,可以查看自动释放池的情况
extern void _objc_autoreleasePoolPrint(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {  //  r1 = push()
        FHPerson *p1 = [[[FHPerson alloc] init] autorelease];
        FHPerson *p2 = [[[FHPerson alloc] init] autorelease];
        @autoreleasepool { // r2 = push()
           for (int i = 0; i < 600; i++) {
               FHPerson *p3 = [[[FHPerson alloc] init] autorelease];
           }
           @autoreleasepool { // r3 = push()
               FHPerson *p4 = [[[FHPerson alloc] init] autorelease];
               _objc_autoreleasePoolPrint();
           } // pop(r3)
        } // pop(r2)
    } // pop(r1)
    return 0;
}

/*

struct __AtAutoreleasePool {
   __AtAutoreleasePool() { // 构造函数，在创建结构体的时候调用
       atautoreleasepoolobj = objc_autoreleasePoolPush();
   }

   ~__AtAutoreleasePool() { // 析构函数，在结构体销毁的时候调用
       objc_autoreleasePoolPop(atautoreleasepoolobj);
   }

   void * atautoreleasepoolobj;
};

{
   __AtAutoreleasePool __autoreleasepool;
   MJPerson *person = ((MJPerson *(*)(id, SEL))(void *)objc_msgSend)((id)((MJPerson *(*)(id, SEL))(void *)objc_msgSend)((id)((MJPerson *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("MJPerson"), sel_registerName("alloc")), sel_registerName("init")), sel_registerName("autorelease"));
}


   atautoreleasepoolobj = objc_autoreleasePoolPush();

   MJPerson *person = [[[MJPerson alloc] init] autorelease];

   objc_autoreleasePoolPop(atautoreleasepoolobj);
*/
