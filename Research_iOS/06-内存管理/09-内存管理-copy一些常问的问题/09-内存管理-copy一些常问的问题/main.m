//
//  main.m
//  09-内存管理-copy一些常问的问题
//
//  Created by wangfh on 2020/7/30.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FHPerson *p = [[[FHPerson alloc] init] autorelease];
        
        /*
         为什么字符串用copy修饰?
             FHPerson的name是retain修饰的,当我们修改str的时候,会影响到p.name
             所以使用copy去产生一个新对象,你外部随便怎么改,我自己内部是不会变的
         */
        NSMutableString *str = [NSMutableString stringWithFormat:@"hello11111111"];
        p.name = str;
        [str appendString:@"world"];
        NSLog(@"%@",p.name);
        
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        [p setData:tmpArray];
        /*
             1. 为什么p.data中data我使用的是NSMutableArray修饰的,只是用copy修饰,为什么就崩溃了呢?
                 以为对于可变数组(NSMutableArray)的copy,最后的结果返回的会是不可变数组(NSArray),是深拷贝
                 而不可变数组是没有addObject方法的,所以就崩溃了
             
             2. 数组既然不能用copy,那用retain为什么就不担心数据修改的问题?(比如字符串用copy,就是为了防止数据改动)
                如果你想p.data 和 外部的 tmpArray 做两份,那只能使用 mutableCopy, 但属性的修饰符很少有使用mutableCopy修饰的吧
                我觉得,如果你FHPerson中的data,只要不用到可变数组的那些方法,是可以用copy修饰的,因为对于可变数组的拷贝返回的是不可变数组
         
             3. 如果FHPerson的data,用retain修饰(记得注释set方法),可以看到[tmpArray addObject:@"tmac"] 是会影响到p.data的
                这就又回到我2的疑问了,确实是受影响了
         
             4. 那为啥数组就不担心和字符串一样的问题,外界变了,会影响到我
                首先,我们使用字符串的时候,很少会再去操作FHPerson中的name了,就是一个不可变字符串,所以就让他不可变就好了,所以就用copy修饰,产生一个新的对象
                而对于数组,前边也说了,如果你不使用可变数组的那些方法,用copy修饰是没有问题的
                但你既然想用可变数组的那些方法,你就只能用strong,因为属性没有mutablecopy这个关键字,没法让你生成一个新的可变的对象呀,所以就用strong吧
                比如例子中的tmpArray和p.data,如果data用strong修饰,tmpArray增加元素,p.data是会受影响的
    
         注意: 看的时候不要迷, FHPerson中属性的修饰是不对的 data用了copy,name用了retain,只是为了验证问题
         */
        [tmpArray addObject:@"tmac"];
//        [p.data addObject:@"jack"]; // 会崩溃
//        [p.data addObject:@"rose"]; // 会崩溃
        NSLog(@"%@",p.data);
        
    }
    return 0;
}



