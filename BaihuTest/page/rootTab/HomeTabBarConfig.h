//
//  HomeTabBarConfig.h
//  BaihuTest
//
//  Created by liudong on 2020/4/27.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HomeTabBarConfig : NSObject

@property(nonatomic,strong)NSArray* viewController;
@property(nonatomic,strong)NSArray* title;
@property(nonatomic,assign)BOOL isNavigation;
@property(nonatomic,strong)NSArray* seletedImages;
@property(nonatomic,strong)NSArray* normalImage;
@property(nonatomic,strong)UIColor* selectedColor;
@property(nonatomic,strong)UIColor* normalColor;

@end

NS_ASSUME_NONNULL_END
