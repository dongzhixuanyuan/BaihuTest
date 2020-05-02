//
//  HomeTabBar.h
//  BaihuTest
//
//  Created by liudong on 2020/4/27.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeTabBarItem;
@protocol HomeTabBarDelegate;
NS_ASSUME_NONNULL_BEGIN
extern const CGFloat BOTTOM_TABS_HEIGHT;
@interface HomeTabBar : UIView

@property(nonatomic,strong)NSArray<HomeTabBarItem*>* items;
@property(nonatomic,assign) id<HomeTabBarDelegate> delegate;
@end

@protocol HomeTabBarDelegate <NSObject>

-(void)tabBar:(HomeTabBar*) tab didSelectItem:(nonnull HomeTabBarItem *)item atIndex:(NSInteger)index;

@end


NS_ASSUME_NONNULL_END
