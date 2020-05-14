//
//  DimenAdapter.m
//  BaihuTest
//
//  Created by liudong on 2020/4/28.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "DimenAdapter.h"
#import <UIKit/UIKit.h>


///UI设计稿有一个标准值 width:360 height:667
///适配的话，根据设备真实尺寸来按照比例放大缩小。
CGFloat const STATUSBAR_HEIGHT = 44; //只有一些新版本手机的状态栏高度才是44，老版本手机的状态栏高度是24。所以这里应该做一个判断的，但为了省事还是算了吧。
CGFloat const NAVIGATIONBAR_HEIGHT = 44;
CGFloat const HOME_INDICATION_HEIGHT = 34;
@implementation DimenAdapter

+ (CGFloat)dimenAutoFit:(CGFloat)dimen {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat min =  width < height ? width : height;
    return min / 375 * dimen;
}

+ (CGRect)rectAutoFit:(CGRect)rect {
//    CGRect newRect = CGre
    CGFloat width =    [DimenAdapter dimenAutoFit:rect.size.width];
    CGFloat height =    [DimenAdapter dimenAutoFit:rect.size.height];
    return CGRectMake(rect.origin.x, rect.origin.y, width, height);
}

@end
