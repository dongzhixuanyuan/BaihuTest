//
//  DimenAdapter.h
//  BaihuTest
//
//  Created by liudong on 2020/4/28.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DimenAdapter : NSObject
+ (CGFloat)dimenAutoFit:(CGFloat)dimen;
+ (CGRect) rectAutoFit:(CGRect) rect;
@end

NS_ASSUME_NONNULL_END
