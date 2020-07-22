//
//  FHPerson.m
//  01-搞懂isa必备知识
//
//  Created by wangfh on 2020/7/20.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import "FHPerson.h"

#define FHTallMask (1<<0)
#define FHRichMask (1<<1)
#define FHHandsomeMask (1<<2)

@interface FHPerson()
{
    /*
    因为是联合,所以bits和结构体共用一块内存,整个代码只操作了bits,而结构体只是便于我们去阅读代码
    */
    union {
        char bits;
        struct {
            char tall : 1;
            char rich : 1;
            char handsome : 1;
        };
    }_tallRichHandsome;
}
@end

@implementation FHPerson

- (void)setTall:(BOOL)tall {
    if (tall) {
        _tallRichHandsome.bits |= FHTallMask;
    } else {
        _tallRichHandsome.bits &= ~FHTallMask;
    }
}

- (void)setRich:(BOOL)rich {
    if (rich) {
        _tallRichHandsome.bits |= FHRichMask;
    } else {
        _tallRichHandsome.bits &= ~FHRichMask;
    }
}

- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _tallRichHandsome.bits |= FHHandsomeMask;
    } else {
        _tallRichHandsome.bits &= ~FHHandsomeMask;
    }
}

- (BOOL)isTall {
    return !!(_tallRichHandsome.bits & FHTallMask);
}

- (BOOL)isRich {
    return !!(_tallRichHandsome.bits & FHRichMask);
}

- (BOOL)isHandsome {
    return !!(_tallRichHandsome.bits & FHHandsomeMask);
}

@end
