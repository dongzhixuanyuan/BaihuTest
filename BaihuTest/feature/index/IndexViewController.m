//
//  IndexViewController.m
//  BaihuTest
//
//  Created by liudong on 2020/4/30.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "IndexViewController.h"
#import "DimenAdapter.h"
#import "IndexTabContainer.h"
#import "HomeTabBar.h"
#import "PhotoListView.h"
#import "UrlConstants.h"
#import "PhotoWatchViewController.h"
#import "NetworkManager.h"
#import "CategoryModel.h"
#import  <YYModel.h>
@interface IndexViewController () <UIScrollViewDelegate,IndexTabClickDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) IndexTabContainer *tabContaienr;
@property(nonatomic,assign)NSInteger currentSelectedPage;
@end

@implementation IndexViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tabContaienr = [[IndexTabContainer alloc]init];
        _tabContaienr.tabClickDelegate = self;
        [self.view addSubview:_tabContaienr];
        [_tabContaienr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(STATUSBAR_HEIGHT);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.height.mas_equalTo(NAVIGATIONBAR_HEIGHT);
        }];
        [self addObserver:_tabContaienr forKeyPath:@"currentSelectedPage" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self fetchIndexCategories];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT - HOME_INDICATION_HEIGHT - BOTTOM_TABS_HEIGHT)];
        _scrollView.backgroundColor = [UIColor blueColor];
        _scrollView.canCancelContentTouches = NO;
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        _scrollView.clipsToBounds = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.tag = 1;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _currentSelectedPage = 0;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]init];
        gesture.cancelsTouchesInView = NO;
        [_scrollView addGestureRecognizer:gesture];
        PhotoListView* tableView = [[PhotoListView alloc]initWithUrl:[UrlConstants getIndexAllUrl]];
        tableView.clickCallback = ^(PhotoItemDataItem * _Nonnull photoItem) {
            PhotoWatchViewController* newController = [PhotoWatchViewController initWithBean:photoItem];
            [self.navigationController pushViewController:newController animated:YES];
            
        };
        
        
        UIImageView *view2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dream"]];
        UIImageView *view3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"girl"]];
        UIImageView *view4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sky"]];
        [_scrollView addSubview:tableView];
        [_scrollView addSubview:view2];
        [_scrollView addSubview:view3];
        [_scrollView addSubview:view4];
        [self layoutImageViews];
        [self.view addSubview:_scrollView];
        
    }
    return self;
}

- (void)layoutImageViews {
    NSUInteger count = [_scrollView subviews].count;
    if (count <= 0) {
        return;
    }
    CGFloat screenWidth =     CGRectGetWidth(self.view.bounds);
    CGFloat screenHeight =     CGRectGetHeight(self.view.bounds);
    [_scrollView setContentSize:CGSizeMake(screenWidth * count, 0)];//contentsize就是设置scrollview左右或者上下可滚动的范围。设置为0，就表示不能在这个方向上进行滚动。
    for (NSUInteger index = 0; index < count; index++) {
        UIView *child = [_scrollView subviews][index];
        CGPoint position = CGPointMake(index * screenWidth, 0);
        CGRect newFrame = child.frame;
        newFrame.origin = position;
        newFrame.size = CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
        child.frame = newFrame;
    }
}


-(void)fetchIndexCategories {
    __weak __typeof(self) weakSelf = self;
    [NetworkManager.getHttpSessionManager GET:[UrlConstants getCategoryUrl] parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong __typeof(weakSelf) sself = weakSelf;
        CategoryModel* model = [CategoryModel yy_modelWithDictionary:responseObject];
        NSMutableArray<NSString*>* tabData = [NSMutableArray arrayWithCapacity:model.data.count + 2];
        [tabData addObject: @"精选"];
        [tabData addObject: @"最新"];
        for (CategoryDataItem* item in model.data) {
            [tabData addObject: item.name];
        }
        [sself.tabContaienr setTabData:tabData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __strong __typeof(weakSelf) sself = weakSelf;
        NSMutableArray<NSString*>* tabData = [NSMutableArray arrayWithCapacity:2];
        [tabData addObject: @"精选"];
        [tabData addObject: @"最新"];
        [sself.tabContaienr setTabData:tabData];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = _scrollView.contentOffset.x / _scrollView.frame.size.width;
    NSLog(@"当前page:%d",page);
    if(_currentSelectedPage!=page){
        self.currentSelectedPage = page;
    }
    
}

- (void)onTabClick:(NSInteger)position {
    CGFloat screenWidth =   _scrollView.frame.size.width;
    CGPoint destination = CGPointMake(position*screenWidth, 0);
    [_scrollView setContentOffset:destination animated:NO];
}

- (void)dealloc
{
    [self removeObserver:_tabContaienr forKeyPath:@"currentSelectedPage"];
}
@end
