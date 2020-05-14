//
//  IndexTabContainer.h
//  BaihuTest
//
//  Created by liudong on 2020/5/2.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimenAdapter.h"
NS_ASSUME_NONNULL_BEGIN

@protocol IndexTabClickDelegate;

@interface IndexTabContainer : UIScrollView
@property(nonatomic,strong) id<IndexTabClickDelegate> tabClickDelegate;
@property(nonatomic,strong)NSArray<UIView*>* tabs;//items
-(void)fetchCategories;
@end

//tab被点击的回调接口
@protocol IndexTabClickDelegate<NSObject>

-(void)onTabClick:(NSInteger)position;

@end

NS_ASSUME_NONNULL_END
