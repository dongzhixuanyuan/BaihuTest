//
//  HomeTabBarItem.h
//  BaihuTest
//
//  Created by liudong on 2020/4/27.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeTabBarItemDelegate;
@interface HomeTabBarItem : UIView

@property(nonatomic,copy)NSString* icon;
@property(nonatomic,copy)NSString* title;
@property(nonatomic,strong)UIColor* titleColor;

@property(nonatomic,assign) id <HomeTabBarItemDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

@protocol HomeTabBarItemDelegate <NSObject>

-(void)tabBarItem:(HomeTabBarItem*)item didSelectIndex:(NSInteger)index;

@end
