//
//  main.m
//  07-内存管理-mrc-属性出来后
//
//  Created by wangfh on 2020/7/29.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

// ==================== person=======================
@class FHDog;

@interface FHPerson : NSObject

@property (nonatomic, assign) int age;
@property (nonatomic, retain) FHDog *dog;

@end

@implementation FHPerson

// 编译器会自动加上 @synthesize age = _age; 自动生成成员变量和属性的setter、getter实现
// 类似于以下的实现
/*
@synthesize age = _age;
@synthesize dog = _dog;

- (void)setAge:(int)age {
    _age = age;
}

- (int)age {
    return _age;
}

- (void)setDog:(FHDog *)dog {
    if (_dog != dog) {
        [_dog release];
        _dog = [dog retain];
    }
}

- (FHDog *)dog {
    return _dog;
}
 */

// marc下虽然属性帮忙生成了set,get 但还是需要重写dealloc,去释放dog
- (void)dealloc {
    self.dog = nil; // 本质还是 [self setDog:nil];
    NSLog(@"%s",__func__);
    [super dealloc];
}
@end

// ==================== dog =======================
@interface FHDog : NSObject

- (void)run;

@end

@implementation FHDog

- (void)run {
    NSLog(@"%s",__func__);
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    [super dealloc];
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       FHDog *dog = [[FHDog alloc] init]; // 1
       
       FHPerson *person1 = [[FHPerson alloc] init];
       [person1 setDog:dog]; // 2
       
       FHPerson *person2 = [[FHPerson alloc] init];
       [person2 setDog:dog]; // 3
       
       [dog release]; // 2
       
       [person1 release]; // 1
       
       [[person2 dog] run];
       [person2 release]; // 0
    }
    return 0;
}
