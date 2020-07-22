//
//  FHPerson.m
//  01-搞懂isa必备知识
//
//  Created by wangfh on 2020/7/20.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import "FHPerson.h"

@interface FHPerson()
{
    struct {
        char tall : 1;
        char rich : 1;
        char handsome : 1;
    }_tallRichHandsome;
}
@end

@implementation FHPerson

- (void)setTall:(BOOL)tall {
    _tallRichHandsome.tall = tall;
}

- (void)setRich:(BOOL)rich {
    _tallRichHandsome.rich = rich;
}

- (void)setHandsome:(BOOL)handsome {
    _tallRichHandsome.handsome = handsome;
}

- (BOOL)isTall {
    return !!_tallRichHandsome.tall;
}

- (BOOL)isRich {
    return !!_tallRichHandsome.rich;
}

- (BOOL)isHandsome {
    return !!_tallRichHandsome.handsome;
}

@end
