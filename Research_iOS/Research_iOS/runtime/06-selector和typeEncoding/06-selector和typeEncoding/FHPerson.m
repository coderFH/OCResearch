//
//  FHPerson.m
//  06-selector和typeEncoding
//
//  Created by wangfh on 2020/7/20.
//  Copyright © 2020 wangfh. All rights reserved.
//

#import "FHPerson.h"

@implementation FHPerson

- (void)ceshi {
    NSLog(@"2222");
}

- (int)test:(int)age height:(float)height
{
    NSLog(@"%s", __func__);
    return 0;
}
@end
