//
//  main.m
//  06-内存管理-mrc
//
//  Created by wangfh on 2020/7/29.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

// ==================== person=======================
@class FHDog;

@interface FHPerson : NSObject {
    FHDog *_dog;
}
- (void)setDog:(FHDog *)dog;

@end

@implementation FHPerson

- (void)setDog:(FHDog *)dog {
    if (_dog != dog) {
        [_dog release];
        _dog = [dog retain];
    }
}

- (void)dealloc {
    [_dog release];
    _dog = nil;
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

// ==================== main =======================
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // ==================== 1.autorelease=======================
//        FHPerson *person = [[FHPerson new] autorelease]; //autorelease会在恰当的时候调用release
//        NSLog(@"%zd",person.retainCount);
//        NSLog(@"111");
        
        
        // ==================== 2.复杂点的内存管理 =======================
        FHDog *dog = [[FHDog alloc] init]; // d:1
        
        FHPerson *person1 = [[FHPerson alloc] init];  //p:1
        [person1 setDog:dog]; // d:2
        
        FHPerson *person2 = [[FHPerson alloc] init]; //p2:1
        [person2 setDog:dog]; // d:3
        
        [dog release]; // d:2
        
        [person1 release]; // d:1 p1:0
        
        [dog run];
        [person2 release]; // d:0 p2:0
    }
    NSLog(@"2222");
    return 0;
}
