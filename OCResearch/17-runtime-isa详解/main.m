//
//  main.m
//  17-runtime-isa详解
//
//  Created by Ne on 2018/8/8.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    //    FHOptionsNone = 0,    // 0b0000
    FHOptionsOne = 1<<0,   // 0b0001
    FHOptionsTwo = 1<<1,   // 0b0010
    FHOptionsThree = 1<<2, // 0b0100
    FHOptionsFour = 1<<3   // 0b1000
} FHOptions;

void setOptions(FHOptions options) {
    if (options & FHOptionsOne) {
        NSLog(@"包含了FHOptionsOne");
    }
    
    if (options & FHOptionsTwo) {
        NSLog(@"包含了FHOptionsTwo");
    }
    
    if (options & FHOptionsThree) {
        NSLog(@"包含了FHOptionsThree");
    }
    
    if (options & FHOptionsFour) {
        NSLog(@"包含了FHOptionsFour");
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //位运算
        setOptions(FHOptionsOne + FHOptionsTwo + FHOptionsFour);
    }
    return 0;
}
