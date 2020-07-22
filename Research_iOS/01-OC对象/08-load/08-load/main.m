//
//  main.m
//  07-load
//
//  Created by wangfh on 2018/7/17.
//  Copyright © 2018年 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*
         1.首先,main函数什么都没调用,而load方法已经执行,+load方法会在runtime加载类、分类时调用,每个类、分类的+load，在程序运行过程中只调用一次

         2.关于执行顺序:
            a.先类后分类的顺序
            b.先参与编译的会先执行load方法,如果存在继承关系,会先调用父类,再调用子类的顺序
            c.分类的也会实行先编译先执行的操作
         
         调用顺序
            先调用类的+load
            按照编译先后顺序调用（先编译，先调用）
            调用子类的+load之前会先调用父类的+load
         
            再调用分类的+load
            按照编译先后顺序调用（先编译，先调用）

         +load方法是根据方法地址直接调用，并不是经过objc_msgSend函数调用
         */
    }
    return 0;
}
