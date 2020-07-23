//
//  BusinessObject.h
//  41-责任链模式
//
//  Created by wangfh on 2019/10/14.
//  Copyright © 2019 wangfh. All rights reserved.
//

/*
 比如刚开始一个业务的调用顺序是A->B->C,现在产品更改需求,需要调用的顺序是C->B->A,从技术的角度,如何去解决这个问题
 */
#import <Foundation/Foundation.h>

@class BusinessObject;

typedef void(^CompletionBlock)(BOOL handled);
typedef void(^ResultBlock)(BusinessObject * _Nullable handler,BOOL handled);

NS_ASSUME_NONNULL_BEGIN

@interface BusinessObject : NSObject

// 下一个响应者(响应链构成的关键)
@property(nonatomic, strong) BusinessObject * _Nullable nextBusiness;

//响应者的处理方法
- (void)handle:(ResultBlock)result;

//各个业务在该方法中做实际业务处理
- (void)handleBusiness:(CompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
