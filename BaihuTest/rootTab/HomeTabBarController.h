//
//  HomeTabBarController.h
//  BaihuTest
//
//  Created by liudong on 2020/4/27.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTabBarConfig.h"
NS_ASSUME_NONNULL_BEGIN
@class HomeTabBarConfig;
typedef HomeTabBarConfig*(^tabBarBlock)(HomeTabBarConfig* config);
@interface HomeTabBarController : UITabBarController

//是否可用自动旋转屏幕
@property(nonatomic,assign)BOOL isAutoRotation;


/// 创建tabbarcontroller
/// @param block 创想tabBarController所需的参数
/// @return 返回tabBarController对象
+(instancetype) createTabBarController:(tabBarBlock)block;

/// 返回当前的tabbarcontroller实例
+(instancetype)defaultTabBarController;

-(void)hiddenTabBarWithAnimation:(BOOL)animate;

-(void)showTabBarWithAnimation:(BOOL)animate;

@end

NS_ASSUME_NONNULL_END
