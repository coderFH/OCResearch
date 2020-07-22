//
//  main.m
//  06-Category
//
//  Created by Ne on 2018/7/16.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"
/*
 当在一个类中有一个run方法,分类中也有同样的run方法,调用该方法的时候,该调用哪个,为什么?
 首先,肯定会调用分类里面的方法,具体调用哪个分类的方法,哪个最后参与编译,就调用哪个
 还有,需要注意当有多个run方法时,这些方法都会存在类的方法列表(+号方法在元类)中,而不会进行覆盖,只不过分类的方法在最前边,所以就调用了分类的方法
 具体为什么,看源码实现
 */
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHPerson *person = [[FHPerson alloc] init];
        //之所以会调用FHPerson+Eat分类里面的run方法是因为runtime在执行的时候,会把分类的方法加载在类列表的数组中,后编译的会加到数组的前边,所以当类和分类中都有同一个方法(run)时,就优先调用了分类(Eat,因为Eat最后编译)的run
        [person run]; 
    }
    return 0;
}

