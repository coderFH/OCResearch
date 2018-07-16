//
//  main.m
//  06-Category
//
//  Created by Ne on 2018/7/16.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHPerson *person = [[FHPerson alloc] init];
        //之所以会调用FHPerson+Eat分类里面的run方法是因为runtime在执行的时候,会把分类的方法加载在类列表的数组中,后编译的会加到数组的前边,所以当类和分类中都有同一个方法(run)时,就优先调用了分类(Eat,因为Eat最后编译)的run
        [person run]; 
    }
    return 0;
}

