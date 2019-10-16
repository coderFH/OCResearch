//
//  BusinessObjectC.m
//  41-责任链模式
//
//  Created by wangfh on 2019/10/14.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "BusinessObjectC.h"
#import "BusinessObjectB.h"

@implementation BusinessObjectC

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.nextBusiness = nil;
//    }
//    return self;
//}

- (void)handleBusiness:(CompletionBlock)completion {
    NSLog(@"网络请求C");
    completion(NO);
}

@end
