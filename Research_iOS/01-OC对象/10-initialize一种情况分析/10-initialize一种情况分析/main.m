//
//  main.m
//  06-initialize一种情况下的分析
//
//  Created by wangfh on 2020/6/29.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHPerson : NSObject
@end

@implementation FHPerson

+ (void)initialize {
     NSLog(@"FHPerson-initialize");
}
@end

// ---------------------------------
@interface FHStudent : FHPerson
@end

@implementation FHStudent
@end

// ---------------------------------
@interface FHSubStudent : FHStudent
@end

@implementation FHSubStudent
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [FHStudent alloc];
        [FHSubStudent alloc];
        /*
         以上两个方法 会一共调用几次initialize?
         通过打印方法可知,会调用三次FHPerson-initialize
         但是在我们的理解当中,initialize只会在该类接收到消息的时候调用一次,这里为什么会调用三次?
         首先 我们需要理解initialize是属于消息发送机制,当子类没有实现该方法的时候,会通过superclass指针去找父类方法进行调用
         所以当我们执行 [FHStudent alloc] 的时候  FHStudent 会先调用父类 FHPerson 的 initialize方法 所以打印一次
         然后 到 FHStudent, 因为FHStudent没有实现initialize方法,所以找到父类FHPerson的initialize方法,所以打印了第二次
         当执行 [FHSubStudent alloc] 也会先去调用父类(FHStudent,FHPerson)的 initialize 方法,因为父类initialize方法之前已经调用过,所以就不再调用
         最后 调用FHSubStudent的initialize方法,因为FHSubStudent没有实现initialize,最后又会走到FHPerson的initialize方法,所以打印了第三次
         */
    }
    return 0;
}



