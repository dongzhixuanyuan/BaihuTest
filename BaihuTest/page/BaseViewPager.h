//
//  BaseViewPager.h
//  BaihuTest
//
//  Created by liudong on 2020/6/3.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexTabContainer.h"
NS_ASSUME_NONNULL_BEGIN

//一个基类 定义了顶部tab以及下面的scroollview，并完成联动。类似于android的viewpager
@interface BaseViewPager : UIViewController
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) IndexTabContainer *tabContaienr;
@property(nonatomic,assign)NSInteger currentSelectedPage;
-(void)layoutAllPhotoTableViews;
@end

NS_ASSUME_NONNULL_END
