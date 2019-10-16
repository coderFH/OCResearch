//
//  main.m
//  03-OC对象-探究方法的调用
//
//  Created by wangfh on 2018/7/12.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Test.h"

/*
 instance的isa指向class
 
 class的isa指向meta-class
 
 meta-class的isa指向基类的meta-class
 
 class的superclass指向父类的class
 如果没有父类，superclass指针为nil
 
 meta-class的superclass指向父类的meta-class
 基类的meta-class的superclass指向基类的class
 
 instance调用对象方法的轨迹
 isa找到class，方法不存在，就通过superclass找父类
 
 class调用类方法的轨迹
 isa找meta-class，方法不存在，就通过superclass找父类
 */

@interface FHPerson : NSObject
- (void)run;
@end

@implementation FHPerson
- (void)run {
    NSLog(@"%@我在跑",self);
}
@end

@interface FHStudent : FHPerson
@end

@implementation FHStudent
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHStudent *stu = [[FHStudent alloc] init];
        //调用的顺序是:通过实例对象的isa找到类对象,如果类对象中没有run方法,会通过superClass指针,看看父类有没有该方法,有就调用,没有就会报错
        [stu run];
        
        //这个调用顺序可以看到,NSObject分类中有个实例方法- (void)test
        //FHStudent在调用test的时候,通过类对象的isa会找到元类对象,看是否存储有test方法,
        //没有就会通过superClass找到父类看看是否有test方法,如果还没有
        //会到根元素的元类中去找,如果还没有
        //此时会通过元类的superClass找到类对象,看是否有-号开头的test方法,有就会调用
        [FHStudent test];
    }
    return 0;
}
