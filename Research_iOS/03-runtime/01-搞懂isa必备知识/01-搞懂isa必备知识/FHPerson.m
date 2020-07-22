//
//  FHPerson.m
//  01-搞懂isa必备知识
//
//  Created by wangfh on 2020/7/20.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import "FHPerson.h"

//#define FHTallMask 1
//#define FHRichMask 2
//#define FHHandsomeMask 4

//#define FHTallMask 0b00000001
//#define FHRichMask 0b00000010
//#define FHHandsomeMask 0b00000100

#define FHTallMask (1<<0)
#define FHRichMask (1<<1)
#define FHHandsomeMask (1<<2)

@interface FHPerson()
{
    char _tallRichHandsome;
}
@end

@implementation FHPerson

- (instancetype)init {
    self = [super init];
    if (self) {
        _tallRichHandsome = 0b00000000;
    }
    return self;
}

/*
 如何设置某一位,比如我设置倒数第三位这个1,想设置的位设为1,其他位设为0,按位 |
  0000 0000
| 0000 0100
 ----------
  0000 0100
 
 把某一位设置为0,掩码取反,然后按位&
  0000 0100
& 1111 1011
------------
  0000 0000
*/
- (void)setTall:(BOOL)tall {
    if (tall) {
        _tallRichHandsome |= FHTallMask;
    } else {
        _tallRichHandsome &= ~FHTallMask;
    }
}

- (void)setRich:(BOOL)rich {
    if (rich) {
        _tallRichHandsome |= FHRichMask;
    } else {
        _tallRichHandsome &= ~FHRichMask;
    }
}

- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _tallRichHandsome |= FHHandsomeMask;
    } else {
        _tallRichHandsome &= ~FHHandsomeMask;
    }
}

/*
 如何取出某一位,比如我想取出倒数第三位这个1,想取的位设为1,其他位设为0,按位&
  0000 0101
& 0000 0100
 ----------
  0000 0100
*/
- (BOOL)isTall {
    return !!(_tallRichHandsome & FHTallMask);
}

- (BOOL)isRich {
    return !!(_tallRichHandsome & FHRichMask);
}

- (BOOL)isHandsome {
    /*
     注意: 假如_tallRichHandsome此时是0000 0100 & 0000 0100之后,结果是 0000 0100,这个结果很明显是4
     但该方法是返回BOOL值,所以取! 即 !4 == 0  然后再取! 即!0 == 1 ,结果就return YES
     */
    return !!(_tallRichHandsome & FHHandsomeMask);
}

@end
