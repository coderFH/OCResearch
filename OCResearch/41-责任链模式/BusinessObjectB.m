//
//  BusinessObjectB.m
//  41-责任链模式
//
//  Created by wangfh on 2019/10/14.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "BusinessObjectB.h"
#import "BusinessObjectC.h"

@implementation BusinessObjectB

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.nextBusiness = [[BusinessObjectC alloc] init];
//    }
//    return self;
//}
- (void)handleBusiness:(CompletionBlock)completion {
    NSLog(@"网络请求B");
    completion(NO);
}


@end
