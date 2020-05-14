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

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define UI(x) [DimenAdapter dimenAutoFit:x]

extern CGFloat const STATUSBAR_HEIGHT;
extern CGFloat const NAVIGATIONBAR_HEIGHT;
extern CGFloat const HOME_INDICATION_HEIGHT;
@interface DimenAdapter : NSObject

+ (CGFloat)dimenAutoFit:(CGFloat)dimen;
+ (CGRect) rectAutoFit:(CGRect) rect;
@end

NS_ASSUME_NONNULL_END
