//
//  FHPerson.m
//  19-runtime-@dynamic
//
//  Created by wangfh on 2018/8/23.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import "FHPerson.h"
#import <objc/runtime.h>

@implementation FHPerson

// 提醒编译器不要自动生成setter和getter的实现、不要自动生成成员变量,我要动态的去实现setterg和getter方法
@dynamic age;

void setAge(id self, SEL _cmd, int age)
{
    NSLog(@"age is %d", age);
}

int age(id self, SEL _cmd)
{
    return 120;
}

//我去动态的添加方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(setAge:)) {
        class_addMethod(self, sel, (IMP)setAge, "v@:i");
        return YES;
    } else if (sel == @selector(age)) {
        class_addMethod(self, sel, (IMP)age, "i@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//@synthesize age = _age 其实就是告诉编译器age属性会生成一个_age的成员变量,并且会生产setter和getter方法的实现

//@synthesize就是告诉编译器age属性生成的成员变量是_age1222
//在xcode4.4以前 声明一个属性后 一般会跟上 age = _age;
//xcode4.4以后 编译器做了优化 会自动的加上这句话
//@synthesize age = _age1222;
//
//- (void)setAge:(int)age
//{
//    _age1222 = age;
//}
//
//- (int)age
//{
//    return _age1222;
//}

@end
