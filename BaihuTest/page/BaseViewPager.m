//
//  BaseViewPager.m
//  BaihuTest
//
//  Created by liudong on 2020/6/3.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "BaseViewPager.h"
#import <Masonry.h>


#import "DimenAdapter.h"
#import "HomeTabBar.h"
@interface BaseViewPager ()<UIScrollViewDelegate,IndexTabClickDelegate>
@end

@implementation BaseViewPager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabContaienr = [[IndexTabContainer alloc]init];
        self.tabContaienr.tabClickDelegate = self;
        [self.view addSubview:self.tabContaienr];
        [self.tabContaienr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(STATUSBAR_HEIGHT);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.height.mas_equalTo(NAVIGATIONBAR_HEIGHT);
        }];
        [self addObserver:self.tabContaienr forKeyPath:@"currentSelectedPage" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT  - UI(70))];
        self.mainScrollView.canCancelContentTouches = NO;
        self.mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        self.mainScrollView.clipsToBounds = YES;
        self.mainScrollView.pagingEnabled = YES;
        self.mainScrollView.delegate = self;
        self.mainScrollView.tag = 1;
        self.mainScrollView.showsHorizontalScrollIndicator = NO;
        self.mainScrollView.showsVerticalScrollIndicator = NO;
        _currentSelectedPage = 0;
        [self.view addSubview:self.mainScrollView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)layoutAllPhotoTableViews {
    NSUInteger count = [self.mainScrollView subviews].count;
    if (count <= 0) {
        return;
    }
    CGFloat screenWidth =     CGRectGetWidth(self.view.bounds);
    CGFloat screenHeight =     CGRectGetHeight(self.view.bounds);
    [self.mainScrollView setContentSize:CGSizeMake(screenWidth * count, 0)];//contentsize就是设置scrollview左右或者上下可滚动的范围。设置为0，就表示不能在这个方向上进行滚动。
    for (NSUInteger index = 0; index < count; index++) {
        UIView *child = [self.mainScrollView subviews][index];
        CGPoint position = CGPointMake(index * screenWidth, 0);
        CGRect newFrame = child.frame;
        newFrame.origin = position;
        newFrame.size = CGSizeMake(CGRectGetWidth(self.mainScrollView.frame), CGRectGetHeight(self.mainScrollView.frame));
        child.frame = newFrame;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = self.mainScrollView.contentOffset.x / self.mainScrollView.frame.size.width;
    NSLog(@"当前page:%d",page);
    if(_currentSelectedPage!=page){
        self.currentSelectedPage = page;
    }
    
}

- (void)onTabClick:(NSInteger)position {
    CGFloat screenWidth =   self.mainScrollView.frame.size.width;
    CGPoint destination = CGPointMake(position*screenWidth, 0);
    [self.mainScrollView setContentOffset:destination animated:NO];
}

- (void)dealloc
{
    [self removeObserver:self.tabContaienr forKeyPath:@"currentSelectedPage"];
}


@end
