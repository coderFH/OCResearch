//
//  ViewController.m
//  04-isa详解
//
//  Created by wangfh on 2020/7/20.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "FHPerson.h"

/*
苹果官方源码

#   define ISA_MASK        0x0000000ffffffff8ULL  //该mask取出shiftcls,也就是类或者元类对象的内存地址
#   define ISA_MAGIC_MASK  0x000003f000000001ULL
#   define ISA_MAGIC_VALUE 0x000001a000000001ULL

 union isa_t {
     Class cls;
     uintptr_t bits;
     struct {
         uintptr_t nonpointer        : 1;                                       \
         uintptr_t has_assoc         : 1;                                       \
         uintptr_t has_cxx_dtor      : 1;                                       \
         uintptr_t shiftcls          : 33; MACH_VM_MAX_ADDRESS 0x1000000000 \
         uintptr_t magic             : 6;                                       \
         uintptr_t weakly_referenced : 1;                                       \
         uintptr_t deallocating      : 1;                                       \
         uintptr_t has_sidetable_rc  : 1;                                       \
         uintptr_t extra_rc          : 19
     };
 };
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
        通过上边源码分析可知,在获取类对象或者元类对象地址的时候,会&上一个ISA_MASK,而ISA_MASK对应的二进制,最后的三位是0,所以由此可以推出一个结论,所以类对象或者元类对象的地址,最后的三位一定是000
    */
    NSLog(@"%p", [ViewController class]); //0x10633a440
    NSLog(@"%p", object_getClass([ViewController class])); //0x10633a468  8对应的二进制 1000 后三位是0
    NSLog(@"%p", [FHPerson class]);//0x10633a508
    NSLog(@"%p", object_getClass([FHPerson class]));//0x10633a4e0
    
    /*
     注意: 跑这个结果,一定使用真机
     通过 lldb 打印person的isa,p/x person->isa
     得到isa是 0x000005a1001bd543 使用计算器计算 发现
     第一位是1  说明经过了isa的优化
     第二是是1  说明设置了关联对象
     第42位是1  说明有弱引用指向过
     */
    FHPerson *person = [[FHPerson alloc] init];
    __weak FHPerson *weakPerson = person;
    objc_setAssociatedObject(person, @"name", @"jack", OBJC_ASSOCIATION_COPY);
    NSLog(@"%@",person);
}


@end
