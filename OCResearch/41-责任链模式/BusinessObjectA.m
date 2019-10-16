//
//  BusinessObjectA.m
//  41-责任链模式
//
//  Created by wangfh on 2019/10/14.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "BusinessObjectA.h"
#import "BusinessObjectB.h"

@implementation BusinessObjectA

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.nextBusiness = [[BusinessObjectB alloc] init];
//    }
//    return self;
//}

- (void)handleBusiness:(CompletionBlock)completion {
    NSLog(@"网络请求A");
    completion(NO);
}

@end
